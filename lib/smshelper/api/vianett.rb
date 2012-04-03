module Smshelper
  module Api
    class Vianett < Base
      base_uri 'http://smsc.vianett.no/V3/CPA/MT'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.vianett[:uname], :password => config.vianett[:passwd]
        super
      end

      def send_message(message)
        uuid = (Digest::CRC32.hexdigest @uuid.generate).unpack('U*').collect {|x| sprintf '%02X', x}.join

        options = {
          :destinationaddr => message.recipient,
          :message => message.text,
          :sourceaddr => message.sender,
          :refno => '1',
          :msgid => uuid}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (post 'MT.ashx', :extra_query => options)
        process_response_code(resp['ack']) ? (@sent_message_ids << uuid; uuid) : (raise ErrorDuringSend, "#{self.class.name} does not implement detailed errors")
      end

      def get_balance
        {:fake => :value}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      private

      def process_response_code(code)
        (code == 'OK') ? true : false
      end

    end
  end
end
