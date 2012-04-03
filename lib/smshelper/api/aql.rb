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
        (post 'sms_gw.php')
      end
    end
  end
end
