require 'open-uri'
class TaobaoBooksController < BaseController
  #before_filter :syn_taobao,:only => :search_douban
  def index
    @search = TaobaoBook.nick_is(taobao_session.top_params["visitor_nick"]).search(params[:search])
    @taobao_books = @search.paginate :page => params[:page],:order => "created_at DESC"
    @taobao_books_ids = @search.all(:select => "items.num_iid",:order => "items.created_at DESC").collect {|book| book.id }
    #从豆瓣查询对应的书籍信息
    @douban_books = Hash.new
    #根据isbn查找书籍
    douban = Douban::Douban.new
    @taobao_books.each do |book|
      douban_book = douban.get_book(book.isbn10)
      @douban_books[book.id] = douban_book if !douban_book.blank?
    end
  end
  def search_douban
    @debug_rsp = ""
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

    if @douban_books.size == 0
      flash[:error] = "未查询到符合条件的书籍."
      render :action => :search_douban
    else
      flash[:notice] = "查到#{@douban_books.size}本符合条件的书籍."
      render "shared/index_douban",:locals => {:show_mark_btn => true }
    end
  end
  #批量更新宝贝信息
  #PUT taobao_books/batch_update
  def batch_update
    @taobao_book = TaobaoBook.find(params[:id])
    update_success = true
    begin
      set_batch_update(@taobao_book)
      flash[:notice] = "#{@taobao_book.title}信息更新成功."
    rescue
      update_success = false
      flash[:error] = "#{@taobao_book.title}信息更新失败."
    end
    render :partial => "shared/update_flash.rjs",:status => (update_success ? :ok : :bad_request)
  end
  #从豆瓣更新宝贝信息
  #PUT /taobao_book/:id/update_from_douban
  def update_from_douban
    @taobao_book = TaobaoBook.find(params[:id])
    save_success = true
    begin
      savebook2taobao(@taobao_book)
      flash[:notice] = "#{@taobao_book.title}信息更新成功."
    rescue
      save_success = false
      flash[:error] = "#{@taobao_book.title}信息更新失败."
    end
    render :partial => "shared/update_flash.rjs",:status => (save_success ? :ok : :bad_request)

  end
  #批量上传书籍信息
  #POST taobao_books/upload_items
  def upload_item
    @taobao_book = TaobaoBook.new
    save_success = true
    begin
      savebook2taobao(@taobao_book)
      flash[:notice] = "#{@taobao_book.title}已成功上传至淘宝."
    rescue
      save_success = false
      flash[:error] = "#{@taobao_book.title}上传失败."
    end

    render :partial => "after_upload.rjs",:status => (save_success ? :ok : :bad_request),:locals => {:taobao_book => @taobao_book}
  end
  private
  #设置douban书籍的属性
  def set_douban_attr(taobao_book)
    select_attrs = params[:select_attrs]

    #只更新选定的属性
    select_attrs.each do |attr|
      taobao_book.send("#{attr}=",params[:douban_book][attr.to_sym]) if TaobaoBook.attr_names.keys.include?(attr.to_sym) and select_attrs.include?(attr)
    end
    #装帧
    taobao_book.book_binding = params[:douban_book][:binding] if select_attrs.include?("binding")
    #描述
    taobao_book.desc = params[:douban_book][:summary] if select_attrs.include?("summary")
    #价格,豆瓣返回的价格带有汉字,需要解析处理
    price = params[:douban_book][:price].scan(/\d{1,10}\.?\d{0,2}/).first if !params[:douban_book][:price].blank?
    taobao_book.price = price
    taobao_book.num = params[:douban_book][:num]
    #书名
    taobao_book.title = params[:douban_book][:title] if select_attrs.include?("summary")
  end
  #根据传入的参数设置taobao_book的公用属性
  def set_public_attr(taobao_book)
    taobao_book.stuff_status = params[:taobao_book][:stuff_status]
    taobao_book.cid = params[:taobao_book][:cid]
    taobao_book.state = LocalArea.find(params[:taobao_book][:state]).name
    taobao_book.city = LocalArea.find(params[:taobao_book][:city]).name
    taobao_book.freight_payer = params[:taobao_book][:freight_payer]

    if params[:taobao_book][:freight_payer] == 'buyer'
      if params[:taobao_book][:post_fee_type] == 'postage_tmp'
        taobao_book.postage_id = params[:taobao_book][:postage_id]
      else
        taobao_book.post_fee = params[:taobao_book][:post_fee]
        taobao_book.express_fee = params[:taobao_book][:express_fee]
        taobao_book.ems_fee = params[:taobao_book][:ems_fee]
      end
    end

    taobao_book.list_time = nil if params[:taobao_book][:list_time_type] == 'immidiate'
    taobao_book.list_time =  params[:taobao_book][:list_time] if params[:taobao_book][:list_time_type] == 'config'

    taobao_book.approve_status = "onsale" 
    taobao_book.approve_status = "instock" if params[:taobao_book][:list_time_type] == 'instock'
    taobao_book.item_seller_cats.build(:cid => params[:taobao_book][:seller_cids])
    taobao_book.has_showcase = params[:taobao_book][:has_showcase]
  end
  #保存书籍信息到淘宝
  def savebook2taobao(taobao_book)
    set_public_attr(taobao_book) unless params[:taobao_book].blank?
    set_douban_attr(taobao_book) unless params[:douban_book].blank?
    #封面图片
    cover = nil
    if params[:select_attrs].include?("image") and !params[:douban_book][:image].blank?
      cover = get_remote_pic(params[:douban_book][:image])
    end
    #TODO 设置事务处理
    #更新数据到淘宝
    sess = taobao_session
    if !cover.blank?
      @taobao_book.save2taobao(sess,'image' => cover)
    else
      @taobao_book.save2taobao(sess)
    end
    @taobao_book.save
  end
  #设置批量更新操作
  def set_batch_update(taobao_book)
    #只更新选定的宝贝属性
    select_attr = params[:batch_update]
    #标题前后缀
    taobao_book.title = params[:pub_book_attr][:pre_title] + @taobao_book.title if select_attr.include?("pre_title") and !params[:pub_book_attr][:pre_title].blank?
    taobao_book.title = @taobao_book.title + params[:pub_book_attr][:after_title]  if select_attr.include?("after_title") and !params[:pub_book_attr][:after_title].blank?
    #价格
    taobao_book.price = params[:taobao_book][:price] if select_attr.include?("price") and !params[:taobao_book][:price].blank?

    #数量
    taobao_book.num = params[:taobao_book][:num] if select_attr.include?("num") and !params[:taobao_book][:num].blank?

    #运费

    taobao_book.freight_payer = params[:pub_book_attr][:freight_payer]
    if params[:pub_book_attr][:freight_payer] == 'buyer'

      if params[:pub_book_attr][:post_fee_type] == 'postage_tmp'
        taobao_book.postage_id = params[:pub_book_attr][:postage_id]
      else
        taobao_book.post_fee = params[:pub_book_attr][:post_fee]
        taobao_book.express_fee = params[:pub_book_attr][:express_fee]
        taobao_book.ems_fee = params[:pub_book_attr][:ems_fee]
      end
    end
    #所属类目
    taobao_book.item_seller_cats.build(:cid => params[:pub_book_attr][:seller_cids])

    sess = taobao_session
    sess = Taobao::SessionKey.get_session('chengqi')
    taobao_book.save2taobao(sess)
    taobao_book.save

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
  #从淘宝同步数据
  def syn_taobao
    sess = taobao_sesssion
    nick = sess.top_params['visitor_nick']
    if TaobaoBook.has_increment?(sess)
      redirect_to syn_page_syn_taobao_datas_path
    end
  end

end
