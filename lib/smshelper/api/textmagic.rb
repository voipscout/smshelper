module Smshelper
  module Api
    class Textmagic < Base

      # base_uri 'https://www.textmagic.com/app'

      def initialize(*args)
        config = args.shift
        @api = TextMagic::API.new config.textmagic[:uname], config.textmagic[:passwd]
        super
      end

      def send_message(message)
        resp = (@api.send message.text, message.recipient, :from => message.sender).to_s
        @sent_message_ids << resp
        resp
      end

      def get_balance
        {'Credits' => @api.account.balance}
      end

      def get_status(message_id)
        raise NotImplementedError, "Sms status checks unsupported by #{self.class.name}"
      end

      def get_callback_response(args = {})
        DeliveryReport.new(
                           :message_id => args['message_id'],
                           :timestamp => Time.now,
                           :delivered => ((args['status'] =~ /d/) ? true : false),
                           :original_params => args
                           )
      end
    end
  end
end
