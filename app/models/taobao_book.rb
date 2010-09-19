class TaobaoBook < BaseItem
  #isbn 编号
  ISBN_PID = 1636953
  #出版日期
  PUBDATE_PID = 2043193
  #页数
  PAGES_PID = 2043202
  #出版社
  PUBLISHER_PID = 2043191
  #版次印次2043197
  PUBNO_PID = 2043197
  #作者2043189
  AUTHOR_PID = 2043189
  #开本2045741
  KAI_PID = 2045741
  #装帧2045745
  BINDING_PID = 2045745
  # 印数2045748
  PUBCOUNT_PID = 2045748
  #字数2045749
  WORDNUM_PID = 2045749
  #副书名2045751
  FUNAME_PID = 2045751
  #正文语种2045752
  LANGUAGE_PID = 2045752
  #定义属性方法名称
  def self.attr_names
    { 
      :isbn13 => [ISBN_PID,"ISBN编号"],
      :pubdate => [PUBDATE_PID,"出版日期"],
      :pages => [PAGES_PID,"页数"],
      :publisher => [PUBLISHER_PID,"出版社"],
      :pubno => [PUBNO_PID,"版次印次"],
      :author => [AUTHOR_PID,"作者"],
      :kai => [KAI_PID,"开本"],
      :book_binding => [BINDING_PID,"装帧"],
      :pubcount => [PUBCOUNT_PID,"印数"],
      :wordnum => [WORDNUM_PID,"字数"],
      :funame => [FUNAME_PID,"副书名"],
      :language => [LANGUAGE_PID,"正文语种"]
    } 
  end
  #定义属性
  TaobaoBook.attr_names.keys.each do |attr_name|
    method_1 = %Q{ def #{attr_name.to_s}() prop TaobaoBook.attr_names[:#{attr_name}].first end }
    method_2 = %Q{ def #{attr_name.to_s}=(v) set_prop TaobaoBook.attr_names[:#{attr_name}].first,TaobaoBook.attr_names[:#{attr_name}].second,v end }
    TaobaoBook.module_eval(method_1)
    TaobaoBook.module_eval(method_2)
  end
  def input_pids
    self.item_pvs.collect {|pv| pv.pid}.join(',')
  end
  def input_str
    self.item_pvs.collect {|pv| pv.name}.join(',')
  end

  #获取或设置商品属性
  private
  def prop(pid)
    if self.item_pvs.exists?(:pid => pid)
      item_pv = self.item_pvs.all(:conditions => {:pid => pid}).first
      item_pv.name
    else
      ""
    end
  end
  def set_prop(pid,pname,pvalue)
    item_pv = ItemPv.new 
    if self.item_pvs.exists?(:pid => pid)
      item_pv = self.item_pvs.all(:conditions => {:pid => pid}).first
    else
      self.item_pvs << item_pv
    end
    item_pv.pid = pid
    item_pv.prop_name = pname
    item_pv.name = pvalue
    item_pv.name_alias = pvalue
  end
end
