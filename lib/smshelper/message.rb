module Smshelper
  class Message
    attr_accessor :recipient, :text, :sender
    attr_reader :utf_8

    def initialize(attributes = {})
      @recipient = attributes[:recipient]
      @text = attributes[:text]
      @sender = attributes[:sender]
      is_gsm(@text) ? (@utf_8 = false) : (@utf_8 = true)
    end

    def is_gsm(text)
      dl = Smshelper::Languagetools::Charset.instance
      lang = dl.is_gsm(text)
    end

    # def to_hex
    #   @text = @text.unpack('U*').collect {|x| sprintf '%02X', x}.join
    # end

    # convert text to UCS-2 BigEndian
    def to_hex_be
      @text = @text.unpack('U*').collect {|x| sprintf '%04X', x}.join
    end

  end
end
