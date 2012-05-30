require 'hashie'

module Smshelper
  module Api
    path = (File.dirname File.expand_path(__FILE__))
    VERSION = '0.0.1'#File.read('blahblah')

    autoload :Base, "#{path}/api/base"
    autoload :ResponseCodes, "#{path}/api/response_codes"
    autoload :Webtext, "#{path}/api/webtext"
    autoload :Bulksms, "#{path}/api/bulksms"
    autoload :Clickatell, "#{path}/api/clickatell"
    autoload :Textmagic, "#{path}/api/textmagic"
    autoload :Smstrade, "#{path}/api/smstrade"
    autoload :Esendex, "#{path}/api/esendex"
    autoload :Mediaburst, "#{path}/api/mediaburst"
    autoload :Nexmo, "#{path}/api/nexmo"
    autoload :Traitel, "#{path}/api/traitel"

    autoload :Aql, "#{path}/api/aql"
    autoload :Vianett, "#{path}/api/vianett"
    #autoload :Txtnation, "#{path}/api/txtnation"
    #autoload :Totext, "#{path}/api/totext"
    autoload :Mycoolsms, "#{path}/api/mycoolsms"
    autoload :Routomessaging, "#{path}/api/routomessaging"
  end
end
