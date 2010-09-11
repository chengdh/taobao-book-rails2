class DoubanBook < ActiveRecord::Base
  #重写to_s
  def to_s
    attrs = self.attributes
    ["summary","author_intro","image","created_at","updated_at","image","nick","title","isbn10"].each {|key| attrs.delete(key)}
    attrs.values.join("/")
  end
end
