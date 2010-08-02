require 'rexml/document'
require 'rexml/streamlistener'
require 'pp'

module Taobao
  class Parse
    DEBUG = true

    class MyListener
      include REXML::StreamListener
      attr_accessor :result

      class TotalArray < Array
        #以下属性在2.0中无用
        attr_accessor :total
        attr_accessor :totalResults
        attr_accessor :lastModified
        attr_accessor :list

        def push_sym(stack)
        end
      end

      def model_classes
        [
         Taobao::Arg,
         Taobao::ErrorRsp,
         Taobao::SimpleUserInfo,
         Taobao::AppSubscControl,
         Taobao::User,
         Taobao::Location,
         Taobao::UserCredit,
         Taobao::ItemCat,
         Taobao::ItemCategory,
         Taobao::ItemProp,
         Taobao::NotifyItem,
         Taobao::SellerCat,
         Taobao::PropValue,
         Taobao::Item,
         Taobao::ItemCategory,
         Taobao::ItemSearch,
         Taobao::Trade,
         Taobao::Product,
         Taobao::ProductImg,
         Taobao::ProductPropImg,
         Taobao::Shop,
         Taobao::TaobaokeItem
        ]
      end

      def elm_name_to_class_default
        {
          "buyer_credit" => Taobao::UserCredit,
          "seller_credit" => Taobao::UserCredit
        }
      end

      def array_elements
        {
          "SimpleUserInfo-array" => TotalArray,
          "rsp" => TotalArray,
          "prop_values" => TotalArray,
          "product_imgs" => TotalArray,
          "items" => TotalArray,
          "item_props" => TotalArray,
          "item_cats" => TotalArray,
          "notify_items" => TotalArray,
          "item_categories" => TotalArray,
          "prop_values" => TotalArray,
          "products" => TotalArray,
          "seller_cats" => TotalArray,
          "args" => TotalArray
        }
      end

      def elm_name_to_class(name)
        @name_to_class ||= (Hash[*(model_classes.collect {|v| [v.elm_name, v]}.flatten)]).merge(array_elements).merge(elm_name_to_class_default)
        @name_to_class[name]
      end

      def attr_name?(name)
        unless @attr_names
          @attr_names = []
          model_classes.each { |k| @attr_names += k.attr_names }
          @attr_names += [:total]
          @attr_names += [:totalResults]
          @attr_names += [:lastModified]
        end
        if array_elements.keys.include?(name)
          return false
        end
        @attr_names.include?(name.to_sym)
      end

      def initialize
        @stack = TotalArray.new
      end

      def tag_start(name, attrs)
        pp("tag_start[begin] --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}") if DEBUG
        return if (name !="error_response") && (name.include?("response") || name.include?("total_results"))

        s_size = @stack.size

        if attr_name?(name)
          @stack.push("#{name}=".to_sym)
        end


        if k = elm_name_to_class(name)
          @stack.push(k.new)
          attrs.each {|k,v| @stack.last.send("#{k}=", v)}
          @stack.last.push_sym(@stack)
        end

        if @stack.size == s_size # nothing get push to stack
          pp "unknown tag #{name}"
          @stack.push :no_op
        end

        pp("tag_start  [end] --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}") if DEBUG
      end

      def tag_end(name)
        pp("tag_end  [begin] --- #{name} --- #{@stack.inspect}") if DEBUG

        return if (name !="error_response") && (name.include?("response") || name.include?("total_results"))
        @result = @stack.pop

        if @result == :no_op
          pp("  tag_end: NOOP") if DEBUG
        elsif @stack.last.kind_of? Symbol
          pp("  tag_end: assign #{@stack.last}") if DEBUG
          s = @stack.pop
          if s != :no_op
            @stack.last.send(s, @result)
          end

          if @stack.last.is_a? Taobao::Model and name == @stack.last.class.elm_name
            elm = @stack.pop
            if @stack.last.is_a? Array
              @stack.last.push(elm)
            else
              @stack.push(elm)
            end
          end
        elsif @result.kind_of? Array and @stack.size > 0
          pp("  tag_end: assign #{@stack.last}") if DEBUG
          s = @stack.pop
          @stack.last.send(s, @result)
        elsif @result.instance_of?(Symbol)
          pp("  tag_end: assign nil") if DEBUG
          @stack.last.send(@result, nil)
        elsif @stack.last.kind_of? Array
          pp("  tag_end: add to array") if DEBUG
          @stack.last.push @result
        end

        pp("tag_end    [end] --- #{name} --- #{@stack.inspect}") if DEBUG
      end

      def text(text)
        if (t = text.strip) != ""
          @stack.push t
        end
      end

      def cdata(content)
        text(content)
      end

    end

    def process(data)
      listener = MyListener.new
      pp("parse --- #{data}") if DEBUG
      REXML::Document.parse_stream(data, listener)
      listener.result
    rescue Exception => e
      pp e.inspect
      pp e.backtrace
      throw e
    end
  end
end
