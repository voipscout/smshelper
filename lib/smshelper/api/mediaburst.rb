module Smshelper
  module Api
    class Mediaburst < Base
      base_uri 'https://api.mediaburst.co.uk/http'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.mediaburst[:uname], :password => config.mediaburst[:passwd]
        super
      end

      def send_message(message)
        #TODO: rewrite Mediaburst::API.process_response to provide
        #full response data, so that msg_id could be had in @sent_message_ids
        message.utf_8 ? (q = {:msgtype => 'ucs2'}) : (q = {:msgtype => 'text'})
        options = {
          :to => message.recipient,
          :content => message.text,
          :concat => '3',
          :from => message.sender}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (post 'send.aspx', :extra_query => options.merge(q)).to_s.split(' ').last.strip
        process_response_code(resp) ? resp.to_s : (raise ErrorDuringSend, "#{self.class.name} does not provide detailed response codes")
      end

      def get_balance
        {'Messages' => (post 'credit.aspx').split(' ').last}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      private
      def process_response_code(code)
        (code =~ /Error/) ? false : true
      end
    end
  end
end
