class BaseItemObserver < ActiveRecord::Observer
  #监听baseItem的新增事件,设置user_location
  def after_create(item)
    user = User.nick_is(item.nick).first
    user_location = UserLocation.new
    user_location = user.user_location if !user.user_location.blank?
    user_location.state = item.state
    user_location.city = item.city
    user.user_location = user_location
    user.save
  end
end
