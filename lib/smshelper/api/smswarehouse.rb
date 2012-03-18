module Smshelper
  module Api
    class Smswarehouse < Base
      base_uri "http://websms.smswarehouse.com:7800"
      endpoint "websms"

      def initialize(config)
        @uname, @passwd = config.smswarehouse[:uname], config.smswarehouse[:passwd]
        super
      end

      def send_message(message)

        if message.utf_8
          message.to_hex
          @q = {:type => '0', :esm => '64', :dcs => '8'}
          # raise NotImplementedError, "UTF-8 unsupported by #{self.class.name}"
        else
          @q = {:type => '5', :esm => '64', :dcs => '0'}
        end

        options = {
          :user => @uname,
          :pass => @passwd,
          :mno => message.recipient,
          :text => message.text,
          :sid => message.sender}

        resp = (post "webmsg", :extra_query => @q.merge(options)).split('::').last.strip
        @sent_message_ids << resp
        resp
      end

      def get_balance
        @q = {:userid => @uname, :password => @passwd}
        {'EUR' => (post "balanceReport", :extra_query => @q).split(/\n/).last.split('::').last.strip}
      end

      def get_status(message_id)
        options = {:userid => @uname, :password => @passwd}
        resp = (post 'websmsstatus', :extra_query => {:respid => message_id.to_s}.merge(options)).split('-')[1].strip
        @sent_message_statuses[message_id] = []
        [resp].each_with_index do |status, index|
          @sent_message_statuses[message_id] << {"part #{index}" => resp}
        end
        {message_id => @sent_message_statuses[message_id]}
      end

      private
      def process_response_code(code)
        (code == 'DELIVRD') ? true : false
      end
    end
  end
end
