require 'open-uri'
class TaobaoBooksController < BaseController
  def index
    @taobao_books = @search.paginate :page => params[:page],:order => "created_at DESC"
    @taobao_books_ids = @search.all(:select => "num_iid",:order => "created_at DESC").collect {|book| book.id }
    #从豆瓣查询对应的书籍信息
    @douban_books = Hash.new
    #根据isbn查找书籍
    douban = Douban::Douban.new
    @taobao_books.each do |book|
      douban_book = douban.get_book(book.isbn10)
      @douban_books[book.id] = douban_book if !douban_book.blank?
    end
  end
  #从豆瓣更新宝贝信息
  #PUT /taobao_book/:id/update_from_douban
  def update_from_douban
    @taobao_book = TaobaoBook.find(params[:id])
    select_attrs = params[:select_attrs]

    #只更新选定的属性
    select_attrs.each do |attr|
      @taobao_book.send("#{attr}=",params[:douban_book][attr.to_sym]) if TaobaoBook.attr_names.keys.include?(attr.to_sym)
    end
    #装帧
    @taobao_book.book_binding = params[:douban_book][:binding] if select_attrs.include?("binding")
    #描述
    @taobao_book.desc = params[:douban_book][:summary] if select_attrs.include?("summary")
    #价格,豆瓣返回的价格带有汉字,需要解析处理
    price = params[:douban_book][:price].scan(/\d{1,10}\.\d{2}/).first
    @taobao_book.price = price if select_attrs.include?("price")
    #书名
    @taobao_book.title = params[:douban_book][:title] if select_attrs.include?("summary")
    #封面图片
    cover = nil
    if select_attrs.include?("image") and !params[:douban_book][:image].blank?
      cover = get_remote_pic(params[:douban_book][:image])
    end
    #更新数据到淘宝
    #FIXME 测试用,手工设置了session
    sess = Taobao::SessionKey.get_session('chengqi')
    if !cover.blank?
      @taobao_book.save2taobao(sess,'image' => cover)
    else
      @taobao_book.save2taobao(sess)
    end
    @taobao_book.save
  end
  private
  #下载远程服务器图片
  def get_remote_pic(url)
    io = open(url)
    def io.original_filename; base_uri.path.split('/').last; end
    if io.original_filename.blank? 
      nil 
    else
      io
    end
  end
end
