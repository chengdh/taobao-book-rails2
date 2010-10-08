class String 
  def URLDecode
    self.gsub!(/%[a-fA-F0-9]{2}/) { |x| x = x[1..2].hex.chr }
  end

  def URLEncode
    self.gsub!(/[^\w$&\-+.,\/:;=?@]/) { |x| x = format("%%%x", x[0]) }
  end
end
