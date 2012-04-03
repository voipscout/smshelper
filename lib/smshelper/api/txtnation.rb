module Smshelper
  module Api
    class Txtnation < Base
      base_uri 'http://smsc.vianett.no/V3/CPA/MT'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.txtnation[:uname], :password => config.txtnation[:passwd]
        super
      end
    end
  end
end
