module Smshelper
  module Api
    class Mycoolsms < Base
      base_uri 'https://www.my-cool-sms.com/'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.mycoolsms[:uname], :password => config.mycoolsms[:passwd]
        super
      end

      def send_message(message)
        options = {
          :number => message.recipient,
          :message => message.text,
          :senderid => message.sender,
          :function => 'sendSms'}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = JSON.parse(post 'api-socket.php', :extra_query => options)
        process_response_code(resp) ? (@sent_message_ids << resp['smsid']; resp['smsid']) : (raise ErrorDuringSend, resp)
      end

      def get_balance
        {'EUR' => JSON.parse(post 'api-socket.php', :extra_query => {:function => 'getBalance'})['balance']}
      end

      def hlr_lookup(number)
        JSON.parse(post 'api-socket.php', :extra_query => {:function => 'doHlrLookup', :number => number})
      end

      def get_callback_response(args = {})
        DeliveryReport.new(
                           :message_id => args['message_id'],
                           :timestamp => Time.now,
                           :delivered => ((args['status'] == '1') ? true : false),
                           :original_params => args
                           )
      end

      private
      def process_response_code(code)
        code['success']
      end
    end
  end
end
