module Smshelper
  module Api
    class Nexmo < Base
      base_uri 'http://rest.nexmo.com'
      headers 'Accept' => 'application/json'

      def initialize(*args)
        config = args.shift
        @uname, @passwd = config.nexmo[:uname], config.nexmo[:passwd]
        super
      end

      def send_message(message)
        message.utf_8 ? (q = {:type => 'unicode'}) : (q = {:type => 'text'})

        options = {
          :username => @uname,
          :password => @passwd,
          :to => message.recipient,
          :text => message.text,
          :from => message.sender}
        options = options.merge(@extra_options) unless @extra_options.nil?
        options = options.merge(q)
        resp = (post 'sms/json', :extra_query => options)
        process_response_code(resp['messages'].collect{|m| m['status']}.first) ? (@sent_message_ids << resp['messages'].collect{|m| m['message-id']}.first; resp['messages'].collect{|m| m['message-id']}.first) : (raise ErrorDuringSend, 'No response code provided by Nexmo!')
      end

      def get_balance
        {'EUR' => (get "account/get-balance/#{@uname}/#{@passwd}").values.last.to_s}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      def get_callback_response(args = {})
        if args['type']
          InboundMessage.new(
                             :message_id => args['messageId'],
                             :sender => args['msisdn'],
                             :recipient => args['to'],
                             :text => args['text'],
                             :timestamp => Time.parse(args['message-timestamp']),
                             :original_params => args
                             )
        elsif args['network-code']
          DeliveryReport.new(
                             :message_id => args['messageId'],
                             :timestamp => Time.parse(args['message-timestamp']),
                             :delivered => ((args['status'] == 'delivered') ? true : false),
                             :original_params => args
                             )
        else
          UnknownReply.new(args)
        end
      end

      private
      def process_response_code(code)
        (code == '0') ? true : false
      end

    end
  end
end
