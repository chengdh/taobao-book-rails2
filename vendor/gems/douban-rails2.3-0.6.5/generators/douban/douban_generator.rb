class DoubanGenerator < Rails::Generator::Base
  def manifest  
    record do |m|  
      m.file 'douban_controller.rb', 'app/controllers/douban_controller.rb'
      m.file "douban_helper.rb", 'app/helpers/douban_helper.rb'
      m.file "douban.yml", 'config/douban.yml'
      m.route :name => :douban_login,:controller => :douban,:action => :new
      m.route :name => :douban_callback,:controller => :douban,:action => :callback
      m.route :name => :douban_logout,:controller => :douban,:action => :destroy
    end  
  end
end
#为rails genetator添加处理代码
module Rails
  module Generator
    module Commands
      class Base
        def route_code(route_options)
          "map.#{route_options[:name]} '#{route_options[:name]}', :controller => '#{route_options[:controller]}', :action => '#{route_options[:action]}'"
        end
      end

      # Here's a readable version of the long string used above in route_code;
      # but it should be kept on one line to avoid inserting extra whitespace
      # into routes.rb when the generator is run:
      # "map.#{route_options[:name]} '#{route_options[:name]}',
      #     :controller => '#{route_options[:controller]}',
      #     :action => '#{route_options[:action]}'"

      class Create
        def route(route_options)
          sentinel = 'ActionController::Routing::Routes.draw do |map|'
          logger.route route_code(route_options)
          gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |m|
            "#{m}\n  #{route_code(route_options)}\n"
          end
        end
      end

      class Destroy
        def route(route_options)
          logger.remove_route route_code(route_options)
          to_remove = "\n  #{route_code(route_options)}"
          gsub_file 'config/routes.rb', /(#{to_remove})/mi, ''
        end
      end
    end
  end
end
