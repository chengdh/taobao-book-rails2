class String 
  def URLDecode
    CGI::unescape(self)
  end

  def URLEncode
    CGI::escape(self)
  end
end
