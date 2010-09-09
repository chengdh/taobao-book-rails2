class SynTaobaoDatasController < ApplicationController
  #显示同步界面
  def syn_page
    #判断是初次同步还是常规同步
    #FIXME 此处为了测试,手工设置了session
    sess = Taobao::SessionKey.get_session('chengqi')
    if SynLog.exists?(sess.top_params['visitor_nick'])
      #常规同步
      render :action => "syn_page"
    else
      render :action => "init_page"
    end
  end
  #初始化同步
  #同步以下数据
  #商品 items
  #店铺资料 shops
  #店铺积分 shop_scores
  #店铺类目 seller_cats
  #users
  #user_credits
  #user_locations
  #POST syn_taobao_datas/init_syn
  #postage postage_mode
  #item_pvs
  #item_seller_cats
  def syn
    #FIXME 此处为了测试,手工设置了session
    sess = Taobao::SessionKey.get_session('chengqi')
    #同步user信息
    User.synchronize(sess)
    #店铺
    Shop.synchronize(sess)
    #邮费模板
    Postage.synchronize(sess)
    #商品(书籍)
    if params[:increment].blank
      TaobaoBook.synchronize(sess)
      #增量信息订阅
      #FIXME 沙箱环境不支持增量API

    else
      TaobaoBook.synchronize_increment(sess)
    end

    syn_log = SynLog.new
    syn_log = SynLog.find(sess.top_params['visitor_nick']) if SynLog.exists?(sess.top_params['visitor_nick'])
    syn_log.last_syn_time = DateTime.now
    syn_log.id = sess.top_params['visitor_nick']
    if syn_log.save
      flash[:notice] = "同步数据完成."
      render :update do |page| 
        page.redirect_to :root
      end
    else
    end
  end
  #使用增量API订阅变更的信息
  def common_syn
  end
end
