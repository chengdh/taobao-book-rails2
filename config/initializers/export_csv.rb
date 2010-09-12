#为Array类添加导出csv方法
class Array
  def export_csv(options ={})
    #参考http://blog.enjoyrails.com/2008/12/12/rails-导入导出csv数据时的中文编码问题/
    #BOM头信息
    bom = "FFFE".gsub(/\s/,'').to_a.pack("H*")
    bom + self.to_csv(options).utf8_to_utf16
  end
  #将数组中的数据导出为一行
  def export_line_csv
    output = FasterCSV.generate(:col_sep => "\t", :row_sep => "\r\n")do |csv|
      csv << self
    end
    output.utf8_to_utf16
  end
end
#为active_record 添加导入导出方法
module ActiveRecord
  class Base
    def self.export2csv(dir)
      require 'fastercsv'
      records = self.find(:all)
      csv_string = FasterCSV.generate() do |csv|
        records.each do |r|
          attr = r.attributes.delete_if { |key,value| self.primary_key == key }
          csv << ([r.id]  + attr.keys.sort.collect {|key| r[key]})
        end
      end
      file_name = File.join(dir,"#{self.table_name}.csv")
      File.delete(file_name) if File.exist? file_name
      File.open(file_name,"w") do |file|
        file.syswrite csv_string
      end 
    end
    #导入数据到数据表中,包括id
    def self.import_csv(dir)
      require 'fastercsv'
      self.destroy_all
      file_name = File.join(dir,"#{self.table_name}.csv")
      rows = FasterCSV::read(file_name)
      rows.each do |row|
        m = self.new
        #给各个字段赋值
        col_index = 0

        attr = m.attributes.delete_if { |key,value| self.primary_key == key }

        (attr.keys.sort).each do |attr|
          col_index = col_index + 1
          m.send("#{attr}=",row[col_index])
        end
        m.id = row[0]
        m.save
      end
    end
  end
end
