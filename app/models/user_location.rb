#用户地址
class UserLocation < ActiveRecord::Base
  belongs_to :user
end
