require 'nokogiri'
module Douban
  class Parser
    #解析单本书籍信息
    def self.parse_book(book_xml)
      xml_doc = Nokogiri::XML(book_xml)
      book_node = xml_doc.css('entry').first
      return nil if book_node.blank?
      parse_single_book(book_node)
    end
    #解析多本书籍信息
    def self.parse_books(book_xml)
      xml_doc = Nokogiri::XML(book_xml)
      books = Array.new
      books_node = xml_doc.css('entry')
      books_node.each do |book_node|
        books.push parse_single_book(book_node)
      end
      books
    end

    private
    def self.parse_single_book(book_node)
      book = Book.new
      els = book_node.css("db|attribute")
      #给book赋值
      els.each do |el|
        if el['name'] == 'author-intro'
          book.author_intro = el.content
        else
          book.send("#{el['name']}=",el.content)
        end
      end
      title = book_node.css('title').first.content
      content_nodes = book_node.css('summary')
      content = content_nodes.first.content if !content_nodes.blank?
      imgs = book_node.css('link[rel=image]')
      img = imgs.first['href'] if !imgs.blank?
      book.title = title
      book.summary = content
      book.image = img
      book
    end
  end
end
