require 'virtus'

module Smshelper
  module Api
    path = (File.dirname File.expand_path(__FILE__))
    VERSION = '0.1.0'#File.read('blahblah')

    autoload :Base, "#{path}/api/base"
    autoload :ResponseCodes, "#{path}/api/response_codes"

    autoload :Bulksms, "#{path}/api/bulksms"
    autoload :Textmagic, "#{path}/api/textmagic"
    autoload :Smstrade, "#{path}/api/smstrade"
    autoload :Esendex, "#{path}/api/esendex"
    autoload :Mediaburst, "#{path}/api/mediaburst"
    autoload :Nexmo, "#{path}/api/nexmo"
    autoload :Aql, "#{path}/api/aql"
    autoload :Vianett, "#{path}/api/vianett"
    autoload :Mycoolsms, "#{path}/api/mycoolsms"
    autoload :Routomessaging, "#{path}/api/routomessaging"
    # Still no support for get_callback_response

    autoload :Traitel, "#{path}/api/traitel"
    autoload :Clickatell, "#{path}/api/clickatell"
    autoload :Webtext, "#{path}/api/webtext"
    #TODO:
    #autoload :Txtnation, "#{path}/api/txtnation"
    #autoload :Totext, "#{path}/api/totext"
    #autoload :Smswarehouse, "#{path}/api/smswarehouse"
  end
end
