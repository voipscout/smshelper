module Smshelper
  class Message
    #1st sms = 160 chars, 2nd+ = 153 chars.
    attr_accessor :recipient, :text, :sender
    attr_reader :utf_8

    def initialize(attributes = {})
      @recipient = attributes[:recipient]
      @text = attributes[:text]
      @sender = attributes[:sender]
      @lt_dl, @lt_al = attributes[:api].detectlanguage_dot_com, attributes[:api].alchemy_language

      (wtf_lang(@text) == (:en || :english)) ? (@utf_8 = false) : (@utf_8 = true)
    end

    #TODO: Id the language with both APIs, fallback to charset != gsm if api isn't available
    def wtf_lang(text)
      dl = Smshelper::Languagetools::DetectLanguageDotCom.new @lt_dl
      lang = dl.detect text
      return lang.to_sym
    end

    def to_hex
      @text = @text.unpack('U*').collect {|x| sprintf '%02X', x}.join
    end

    def to_hex_be
      @text = @text.unpack('U*').collect {|x| sprintf '%04X', x}.join
    end

  end
end
