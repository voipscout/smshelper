#TODO: different base_uri's for get_balance and send_message
module Smshelper
  module Api
    class Routomessaging < Base

      def initialize(*args)
        config = args.shift
        @uname, @passwd = config.routomessaging[:uname], config.routomessaging[:passwd]
        add_request_options! :skip_endpoint => true
        super
      end

      #send_message TO, MESSAGE, FROM
      def send_message(message)
        uuid = (Digest::CRC32.hexdigest @uuid.generate).unpack('U*').collect {|x| sprintf '%02X', x}.join

        if message.utf_8
          message.to_hex_be
          q = {:type => 'longunicode'}
        else
          q = {:type => 'LongSMS'}
        end

        options = {
          :number => message.recipient,
          :message => message.text,
          :ownnum => message.sender
        }
        options.merge!(@extra_options) unless @extra_options.nil?
        options.merge!(:mess_id => uuid) if options[:delivery]
        options.merge!(:user => @uname, :pass => @passwd)

        resp = (post 'http://smsc5.routotelecom.com/NewSMSsend', :extra_query => options.merge(q))
        process_response_code(resp) ? (@sent_message_ids << uuid; uuid) : (raise ErrorDuringSend, 'error response processing not implemented yet')
      end

      def get_balance
        opts = {:username => @uname, :password => @passwd}
        {'EUR' => (post 'http://smsc6.routotelecom.com/balance.php', :extra_query => opts).gsub("\n", '').to_f.round(4)}
      end

      def hlr_lookup(number)
        opts = {:number => number, :user => @uname, :pass => @passwd}
        (get 'http://hlr.routotelecom.com', :extra_query => opts)
      end

      def get_callback_response(args = {})
          DeliveryReport.new(
                             :message_id => args['mess_id'],
                             :timestamp => Time.now,
                             :delivered => ((args['status'] == '0') ? true : false),
                             :status => @response_code.routomessaging(args['status']),
                             :original_params => args
                             )
      end

      private
      def process_response_code(code)
        (code.gsub!("\n", '') == 'success') ? true : false
      end
    end
  end
end
