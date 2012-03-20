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

    # TODO: Id the language with both APIs, fallback to charset != gsm if api isn't available
    def is_gsm(text)
      dl = Smshelper::Languagetools::Charset.instance
      lang = dl.is_gsm(text)
    end
    # THIS IS ANOTHER TEST
    # @classic shit
    def to_hex
      @text = @text.unpack('U*').collect {|x| sprintf '%02X', x}.join
    end

    # Converts the object into textual markup given a specific format.
    #
    # @param [Symbol] format the format type, `:text` or `:html`
    # @return [String] the object converted into the expected format.
    # AND EVEN MORE CLASS
    def to_hex_be
      @text = @text.unpack('U*').collect {|x| sprintf '%04X', x}.join
    end

  end
end
