module Taobao
  module Rails
    module Controller

      def self.included(base)
        base.extend(ClassMethods)
      end

      def taobao_session
        session[:taobao_session]
      end

      def set_taobao_session
        if params[:top_session]
          session[:taobao_session] = Taobao::Session.new params
          # else 
          #  if session[:taobao_session].blank?
          #    #FIXME 此处手工设置了session
          #   session[:taobao_session] = Taobao::SessionKey.get_session('chengqi')
          # end
        end
      end

      def taobao_auth_url
        ENV['TAOBAO_AUTH_URL'] + ENV['TAOBAO_APP_KEY']
      end

      def taobao_auth_link(name)
        link_to name, taobao_auth_url
      end

      module ClassMethods
        def acts_as_taobao_controller(options = {})
          before_filter :set_taobao_session, options
        end
      end
    end
  end
end

