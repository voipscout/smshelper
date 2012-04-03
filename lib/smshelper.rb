require 'uuid'
require 'digest/crc32'
require 'savon'
require 'textmagic'
require 'mediaburst'
require 'api_smith'

require 'smshelper/api'
require 'smshelper/languagetools'
require 'smshelper/message'
require 'smshelper/config'

module Smshelper
  class NotImplementedError < ArgumentError
  end

  class ErrorDuringSend < ArgumentError
  end
end
