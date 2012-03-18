# -*- coding: utf-8 -*-
module Smshelper
  module Api
    class  Webtext < Base
      base_uri "http://www.webtext.com"
      endpoint "api"

      def initialize(*args)
        config = args.shift
        add_query_options! :api_id => config.webtext[:uname], :api_pwd => config.webtext[:passwd]
        super
      end

      def send_message(message)
        if message.utf_8
          message.to_hex_be
          q = {:unicode => '1', :hex => message.text}
        else
          q = {:txt => message.text}
        end

        options = {:dest => message.recipient, :tag => message.sender}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (post "send_text.html", :extra_query => options.merge(q))
        process_response_code(resp.to_s) ? (@response_code.webtext(resp.to_s)) : (raise ErrorDuringSend, @response_code.webtext(resp))
        # :validity => '2'
      end

      def get_balance
        {'EUR' => (post "get_balance.html").to_s.split(':').last.strip}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      private
      def process_response_code(code)
        (code == '000') ? true : false
      end
    end
  end
end
