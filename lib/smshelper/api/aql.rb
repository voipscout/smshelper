module Smshelper
  module Api
    class Aql < Base
      base_uri 'http://smsc.vianett.no/V3/CPA/MT'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.aql[:uname], :password => config.aql[:passwd]
        super
      end
    end
  end
end
