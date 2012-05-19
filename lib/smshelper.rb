require 'uuid'
require 'digest/crc32'
require 'savon'
require 'textmagic'
require 'json'
require 'api_smith'

module Smshelper
  class NotImplementedError < ArgumentError
  end

  class ErrorDuringSend < ArgumentError
  end

  path = (File.dirname File.expand_path(__FILE__))

  autoload :Api, "#{path}/smshelper/api"
  autoload :Languagetools, "#{path}/smshelper/languagetools"
  autoload :Message, "#{path}/smshelper/message"
  autoload :Config, "#{path}/smshelper/config"
end
