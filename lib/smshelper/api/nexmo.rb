module Smshelper
  module Api
    class Nexmo < Base
      base_uri 'http://rest.nexmo.com'

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
        resp
        # process_response_code(resp.first) ? (@sent_message_ids << resp.last.strip; resp.last.strip) : (raise ErrorDuringSend, @response_code.nexmo(resp.first))
      end

      def get_balance
        raise NotImplementedError, "#{self.class.name} currently does not implemet #get_balance, stay tuned!"
        # (get "account/get-balance/#{@uname}/#{@passwd}")
      end

      def get_status(message_id)

      end

      private
      def process_response_code(code)
        (code == '0') ? true : false
      end

    end
  end
end
