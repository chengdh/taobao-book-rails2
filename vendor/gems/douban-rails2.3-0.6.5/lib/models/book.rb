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
  end
end
