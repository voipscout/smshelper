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
        @sent_message_statuses[message_id] = []
        @sent_message_statuses[message_id] << {"Part 01" => @api.message_status(message_id)}
        {message_id => @sent_message_statuses[message_id]}
      end

      def get_delivery_report(args = {})
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
