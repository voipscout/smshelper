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
        @sent_message_ids << (@api.send message.text, message.recipient, :from => message.sender)
      end

      def get_balance
        {'Credits' => @api.account.balance}
      end

      def get_status(message_id)
        @sent_message_statuses[message_id] = []
        @sent_message_statuses[message_id] << {"Part 01" => @api.message_status(message_id)}
        {message_id => @sent_message_statuses[message_id]}
      end

      # def send_message(*args)
      #   add_query_options! :username => @uname, :password => @passwd

      #   (post 'api', :extra_query => {
      #      :cmd => 'send',
      #      :phone => args.shift,
      #      :text => args.shift,
      #      :from => args.shift,
      #      :unicode => '0'})
      # end

      # def get_balance
      #   add_query_options! :username => @uname, :password => @passwd

      #   (post 'api', :extra_query => {:cmd => 'account'})
      # end
    end
  end
end
