module Smshelper
  module Api
    class Smstrade < Base
      base_uri 'http://gateway.smstrade.de'

      def initialize(*args)
        config = args.shift
        add_query_options! :key => config.smstrade[:api_key]
        super
      end

      def send_message(message)

        if message.utf_8
          message.to_hex_be
          q = {:messagetype => 'unicode',  :concat => '1', :message_id => '1'}
        else
          q = {:concat => '1', :message_id => '1'}
        end

        options = {
          :to => message.recipient,
          :message => message.text,
          :from => message.sender}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (post '', :extra_query => options.merge(q)).split(/\n/)
        process_response_code(resp.first) ? (@sent_message_ids << resp.last; resp.last) : (raise ErrorDuringSend, @response_code.smstrade(resp.first))
      end

      def get_balance
        resp = (post 'credits')
        {'EUR' => resp.parsed_response}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      private
      def process_response_code(code)
        (code == '100') ? true : false
      end
    end
  end
end
