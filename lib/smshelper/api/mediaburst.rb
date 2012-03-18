module Smshelper
  module Api
    class MediaBurst < Base
      def initialize(*args)
        config = args.shift
        @client = Mediaburst::API.new config.mediaburst[:uname], config.mediaburst[:passwd]
        super
      end
      def send_message(message)
        #TODO: rewrite Mediaburst::API.process_response to provide
        #full response data, so that msg_id could be had in @sent_message_ids
        message.utf_8 ? (q = {:msgtype => 'ucs2'}) : (q = {:msgtype => 'text'})
        options = {:concat => '3', :from => message.sender}.merge(q)
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = @client.send_message message.recipient, message.text, options
        process_response_code(resp.values.last.to_s) ? resp.to_s : (raise ErrorDuringSend, @response_code.mediaburst(resp.values.last.to_s))
      end

      def get_balance
        {'Messages' => @client.get_credit}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      private
      def process_response_code(code)
        (code == 'true') ? true : false
      end
    end
  end
end
