module Smshelper
  module Api
    class Smswarehouse < Base
      # base_uri "http://websms.smswarehouse.com:7800"
      # endpoint "websms"

      def initialize(*args)
        config = args.shift
        @uname, @passwd = config.smswarehouse[:uname], config.smswarehouse[:passwd]
        add_request_options! :skip_endpoint => true
        super
      end

      def send_message(message)

        if message.utf_8
          message.to_hex_be
          q = {:type => '0', :esm => '64', :dcs => '8'}
          # raise NotImplementedError, "UTF-8 unsupported by #{self.class.name}"
        else
          #q = {:type => '5', :esm => '64', :dcs => '0'}
          q = {:type => '1', :esm => '0', :dcs => '0'}
        end

        options = {
          :user => @uname,
          :pass => @passwd,
          :mno => message.recipient,
          :text => message.text,
          :sid => message.sender}

        options.merge!(@extra_options) unless @extra_options.nil?

        url = 'http://websms.smswarehouse.com:7800/websms/webmsg'
        resp = (post url, :extra_query => q.merge(options)) #.split('::').last.strip
        @sent_message_ids << resp
        pp resp
        resp
      end

      def get_balance
        opts = {:userid => @uname, :password => @passwd}
        url = 'http://websms.smswarehouse.com:7800/websms/balanceReport'
        {'EUR' => (post url, :extra_query => opts).split(/\n/).last.split('::').last.strip}
      end

      def get_status(message_id)
        url = 'http://websms.smswarehouse.com:7800/websms/websmsstatus'
        options = {:userid => @uname, :password => @passwd}
        resp = (post url, :extra_query => {:respid => message_id.to_s}.merge(options)).split('-')[1].strip
        @sent_message_statuses[message_id] = []
        [resp].each_with_index do |status, index|
          @sent_message_statuses[message_id] << {"part #{index}" => resp}
        end
        {message_id => @sent_message_statuses[message_id]}
      end

      def get_callback_response(args = {})
        if args['notificationType'] == 'MessageReceived'
          InboundMessage.new(
                             :message_id => args['id'],
                             :sender => args['originator'],
                             :recipient => args['recipient'],
                             :text => args['body'],
                             :timestamp => Time.now,
                             :original_params => args
                             )
        elsif args['notificationType'] == 'MessageEvent'
          DeliveryReport.new(
                             :message_id => args['id'],
                             :timestamp => Time.now,
                             :delivered => ((args['eventType'] == 'Delivered') ? true : false),
                             :original_params => args
                             )
        else
          UnknownReply.new(args)
        end
      end

      private
      def process_response_code(code)
        (code == 'DELIVRD') ? true : false
      end
    end
  end
end
