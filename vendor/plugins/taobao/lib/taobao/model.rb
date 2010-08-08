module Taobao
  class Model
    def push_sym(stack)
    end
    #得到字段列表,可以新添加属性
    #options hash列表
    #exclude  需要去除的属性数组
    def self.fields(options = {})
      fields = self.attr_names
      fields -= options[:exclude] if !options[:exclude].blank?
      fields.join(',')
    end
  end
end
