module Smshelper
  module Api
    class Mycoolsms < Base
      base_uri 'https://www.my-cool-sms.com/api-socket.php '

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.mycoolsms[:uname], :password => config.mycoolsms[:passwd]
        super
      end

      def send_message(message)
        (post)
      end

      def get_balance
        (post '', :extra_query => {:function => :getbalance})
      end

      def hlr_lookup(number)

      end
    end
  end
end
