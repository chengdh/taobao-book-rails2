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
    #TODO 设置事务处理
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
  #显示从豆瓣查询书籍界面
  #GET /taobao_books/show_search
  def show_search
  end
  #根据传入的ISBN编号,从豆瓣查书
  #GET /taobao_books/index_douban
  def index_douban
    isbns = params[:isbns]
    #从豆瓣查询对应的书籍信息
    @douban_books = Array.new
    #根据isbn查找书籍
    douban = Douban::Douban.new
    isbns.each do |isbn|
      if !isbn.blank?
        douban_book = douban.get_book(isbn)
        @douban_books.push douban_book if !douban_book.blank?
      end
    end
    @douban_book_isbns = @douban_books.collect {|douban_book| douban_book.isbn13 }
  end
  #批量上传书籍信息
  #POST taobao_books/upload_items
  def upload_item
    @taobao_book = TaobaoBook.new
    #设置公用属性
    set_public_attr(@taobao_book)
    Douban::Book.attr_names.each do |attr|
      @taobao_book.send("#{attr}=",params[attr.to_sym]) if TaobaoBook.attr_names.keys.include?(attr.to_sym)
    end
    #装帧
    @taobao_book.book_binding = params[:binding]
    #描述
    @taobao_book.desc = params[:summary]
    #价格,豆瓣返回的价格带有汉字,需要解析处理
    price = params[:price].scan(/\d{1,10}\.\d{2}/).first
    @taobao_book.price = price
    #书名
    @taobao_book.title = params[:title]
    #封面图片
    cover = get_remote_pic(params[:image])
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
  #根据传入的参数设置taobao_book的公用属性
  def set_public_attr(taobao_book)
    taobao_book.stuff_status = params[:taobao_book][:stuff_status]
    taobao_book.cid = params[:taobao_book][:cid]
    taobao_book.state = params[:taobao_book][:state]
    taobao_book.city = params[:taobao_book][:city]
    taobao_book.freight_payer = params[:taobao_book][:freight_payer]
    if params[:taobao_book][:post_fee_type] == 'postage_tmp'
      taobao_book.postage_id = params[:taobao_book][:postage_id]
    else
      taobao_book.post_fee = params[:taobao_book][:post_fee]
      taobao_book.express_fee = params[:taobao_book][:express_fee]
      taobao_book.ems_fee = params[:taobao_book][:ems_fee]
    end
    taobao_book.list_time = DateTime.now if params[:taobao_book][:list_time_type] == 'immidiate'
    taobao_book.list_time =  params[:taobao_book][:list_time] if params[:taobao_book][:list_time_type] == 'config'

    taobao_book.approve_status = "onsale" 
    taobao_book.approve_status = "instock" if params[:taobao_book][:list_time_type] == 'instock'
    taobao_book.item_seller_cats.build(:cid => params[:taobao_book][:seller_cids])
    taobao_book.has_showcase(:cid => params[:taobao_book][:has_showcase])
  end
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
