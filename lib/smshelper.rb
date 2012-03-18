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
