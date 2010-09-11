class DoubanBooksController < BaseController 
  def index
    @search = DoubanBook.nick_is(taobao_session.top_params["visitor_nick"]).search(params[:search])
    @douban_books = @search.paginate :page => params[:page],:order => "created_at DESC"
    @douban_book_isbns = @douban_books.collect {|douban_book| douban_book.isbn13 }
    render "shared/index_douban"
  end
  def create
    sess = taobao_session
    nick = sess.top_params["visitor_nick"]
    attrs = params[:douban_book]
    attrs.delete("num")
    @douban_book = DoubanBook.new(params[:douban_book])
    #判断原来是否已保存过了
    DoubanBook.destroy_all(:nick => nick,:isbn13 => params[:douban_book][:isbn13]) if DoubanBook.exists?(:nick => nick,:isbn13 => params[:douban_book][:isbn13])
    @douban_book.nick = nick
    save_success = @douban_book.save
    if save_success
      flash[:notice] ="[#{@douban_book.title}]已添加到收藏夹."
    else
      flash[:notice] ="[#{@douban_book.title}]添加到收藏夹失败,请重新添加."
    end
    render :partial => "shared/update_flash.rjs",:status => (save_success ? :ok : :bad_request)
  end
end
