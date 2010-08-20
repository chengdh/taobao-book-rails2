module Douban
  class Book
    def self.attr_names
      [
        :title,:image,:author,:isbn10,:isbn13,:pubdate,
        :pages,:translator,:price,:publisher,:binding,:author_intro,:content
      ]
    end
    for a in attr_names
      attr_accessor a
    end
  end
end
