module Smshelper
  module Api
    class Traitel < Base
      base_uri 'http://api.traitel.com'
      # headers 'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',  'Accept-Language' => 'en-us,en;q=0.5', 'Accept-Encoding' => 'gzip, deflate', 'DNT' => '1', 'Connection' => 'keep-alive'

      def initialize(*args)
        config = args.shift
        add_query_options! :user => config.traitel[:uname], :pass => config.traitel[:passwd] # "\"#{config.traitel[:passwd]}\""
        super
      end

      def send_message(message)
        if message.utf_8
          message.to_hex_be
          q = {:unicode => 'true'}
        else
          q = {}
        end
        options = {
          :to => message.recipient,
          :message => message.text,
          :replyto => message.sender,
          :output => :verbose,
          :concatenate => true
        }
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (get 'smsgateway.pl', :extra_query => options.merge(q)) #; resp.split(',')[2]
        process_response_code(resp) ?  (@sent_message_ids << resp.split(',')[2]).first : (raise ErrorDuringSend "Could not deliver")
      end

      def get_balance
        {'AUD' => (get 'selfserve.pl', :extra_query => {:mode => :balance}).split(' ').last.strip}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      private
      def process_response_code(code)
        code =~ /accepted/ ? true : false
      end
    end
  end
end
