module Smshelper
  module Api
    class Vianett < Base

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.vianett[:uname], :password => config.vianett[:passwd]
        add_request_options! :skip_endpoint => true
        super
      end

      def send_message(message)
        uuid = (Digest::CRC32.hexdigest @uuid.generate).unpack('U*').collect {|x| sprintf '%02X', x}.join

        options = {
          :tel => message.recipient,
          :msg => message.text,
          :senderaddress => message.sender,
          :senderaddresstype => '1',
          :nrq => '1',
          # :refno => '1',
          :msgid => uuid}
        options.merge!(@extra_options) unless @extra_options.nil?
        resp = (post 'http://smsc.vianett.no/V3/CPA/MT/MT.ashx', :extra_query => options)
        process_response_code(resp) ? (@sent_message_ids << uuid; uuid) : (raise ErrorDuringSend, "#{self.class.name} does not implement detailed error reporting - #{resp}")
      end

      def get_balance
        {'EUR' => (post 'http://oldsms.vianett.com/files/balancelimit_check.asp').split('|').last}
      end

      # Vianett provides async lookup as well with callbacks
      def hlr_lookup_synchronous(number)
        opts = {:phonenumber => number}
        (get 'http://smsc.vianett.no/v3/cpa/cpawebservice.asmx/SubmitHLR2', :extra_query => opts )['SubmitHLRResponse']
      end
      alias_method :hlr_lookup, :hlr_lookup_synchronous

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      def get_callback_response(args = {})
        if args['requesttype'] == 'notificationstatus'
          DeliveryReport.new(
                             :message_id => args['refno'],
                             :timestamp => Time.parse(args['now']),
                             :delivered => ((args['Status'] == 'DELIVRD') ? true : false),
                             :original_params => args
                             )
        else
          UnknownReply.new(args)
        end
      end

      private
      def process_response_code(code)
        (code['ack']['__content__'] == 'OK') ? true : false
      end

    end
  end
end
