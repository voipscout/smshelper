module Smshelper
  module Api
    class Aql < Base
      base_uri 'https://gw.aql.com/sms'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.aql[:uname], :password => config.aql[:passwd]
        super
      end

      def send_message(message)
        uuid = (Digest::CRC32.hexdigest @uuid.generate).unpack('U*').collect {|x| sprintf '%02X', x}.join

        message.utf_8 ? (q = {:allow_unicode => '1'}) : (q = {})
        options = {
          :destination => message.recipient,
          :originator => message.sender,
          :message => message.text}
        options = options.merge(@extra_options) unless @extra_options.nil?
        # raise ArgumentError, ":dlr_url is required to track messages" unless options.include?(:dlr_url)
        (options[:dlr_url] = options[:dlr_url] + "?status=%code&destination=%dest&message_id=#{uuid}") if options.include?(:dlr_url)
        resp = (post 'sms_gw.php', :extra_query => options.merge(q))
        process_response_code(resp.to_s) ? (@sent_message_ids << uuid; uuid) : (raise ErrorDuringSend, resp)
      end

      def get_balance
        {'Credits' => (post 'postmsg.php', :extra_query => {:cmd => :credit}).split('=').last}
      end

      def get_status
        raise NotImplementedError, "Aql does not implement status check"
      end

      def process_response_code(code)
        (code =~ /SMS successfuly queued/) ? true : false
      end

      def massage_dlr_url(url)
      end
    end
  end
end
