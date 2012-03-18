module Smshelper
  module Api
    class Clickatell < Base
      base_uri 'http://api.clickatell.com/http'

      def initialize(*args)
        config = args.shift
        add_query_options! :api_id => config.clickatell[:api_key], :user => config.clickatell[:uname], :password => config.clickatell[:passwd]
        super
      end

      def send_message(message)
        if message.utf_8
          message.to_hex_be
          q = {:unicode => '1', :req_feat => '40'}
        else
          q = {:req_feat => '32'}
        end

        options = {
          :to => message.recipient,
          :text => message.text,
          :from => message.sender,
          :queue => '1',
          :escalate => '1',
          :validity => '1',
          :concat => '3'}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (post 'sendmsg', :extra_query => options.merge(q)).split(':')
        process_response_code(resp.first.strip) ? (@sent_message_ids << resp.last.strip; resp.last.strip) : (raise ErrorDuringSend, resp.last.strip)
      end

      def get_balance
        {'Credits' => (post 'getbalance').split(':').last.strip}
      end

      def get_status(message_id)
        resp = (post 'querymsg', :extra_query => {:apimsgid => message_id}).split(':')
        @sent_message_statuses[message_id] = []
        if process_response_code(resp.first.strip)
          @sent_message_statuses[message_id] << {"Part 01" => @response_code.clickatell(resp.last.strip)}
          {message_id => @sent_message_statuses[message_id]}
        else
          raise ErrorDuringSend, resp.last.strip
        end
      end

      private
      def process_response_code(code)
        (code == 'ID') ? true : false
      end
    end
  end
end
