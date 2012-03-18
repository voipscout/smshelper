module Smshelper
  class Config
    attr_accessor :smswarehouse, :routomessaging, :webtext, :bulksms, :clickatell, :textmagic, :smstrade, :esendex, :mediaburst, :nexmo, :detectlanguage_dot_com, :alchemy_language

    def initialize(interfaces = {})
      @smswarehouse = interfaces[:smswarehouse]
      @routomessaging = interfaces[:routomessaging]
      @webtext = interfaces[:webtext]
      @bulksms = interfaces[:bulksms]
      @clickatell = interfaces[:clickatell]
      @textmagic = interfaces[:textmagic]
      @smstrade = interfaces[:smstrade]
      @esendex = interfaces[:esendex]
      @mediaburst = interfaces[:mediaburst]
      @nexmo = interfaces[:nexmo]
      @detectlanguage_dot_com = interfaces[:detectlanguage_dot_com]
      @alchemy_language = interfaces[:alchemy_language]
    end
  end
end
