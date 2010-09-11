module Douban
  class Book
    def self.attr_names
      [
        :title,:subtitle,:aka,:image,:author,:isbn10,:isbn13,:pubdate,
        :pages,:translator,:price,:publisher,:binding,:author_intro,:summary
      ]
    end
    for a in attr_names
      attr_accessor a
    end
    #描述信息
    def to_s
      ret = ""
      (Book.attr_names - [:title,:subtitle,:image,:author_intro,:summary]).each do |attr|
        v = self.send("#{attr}")
        ret += v + "/" unless v.blank?

      end
      ret
    end
  end
end
