# -*- coding: utf-8 -*-
module Smshelper
  module Languagetools

    class Base
      def initialize(api_key)
        @api_key = api_key
      end
    end

    class DetectLanguageDotCom < Base
      include APISmith::Client
      base_uri "http://ws.detectlanguage.com"
      endpoint "0.2"

      def detect(text)
        add_query_options! :key => @api_key
        (post "detect", :extra_query => {:q => text})["data"]["detections"].first["language"]
      end
    end

    class AlchemyLanguage < Base
      include APISmith::Client
      base_uri "http://access.alchemyapi.com/"
      endpoint "calls/text"

      def detect(text)
        add_query_options! :outputMode => 'json', :apikey => @api_key
        (post "TextGetLanguage", :extra_query => {:text => text})["language"]
      end
    end

    class Charset
      include Singleton
      GSM_CHARSET = "@£$¥èéùìòÇ\nØø\rÅåΔ_ΦΓΛΩΠΨΣΘΞ\e\f^{}\\[~]|€ÆæßÉ !\"#¤%&'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzäöñüà".scan(/./u)
      ESCAPED_CHARS = "{}\\~[]|€"
      # Returns +true+ if the supplied text contains only characters from
      # GSM 03.38 charset, otherwise it returns +false+.
      def is_gsm(text)
        text.scan(/./u).each { |c| return false unless GSM_CHARSET.include?(c) }
        true
      end

      # Returns +true+ if the supplied text contains characters outside of
      # GSM 03.38 charset, otherwise it returns +false+.
      def is_unicode(text)
        !is_gsm(text)
      end

      def real_length(text, unicode)
        text.size + (unicode ? 0 : text.scan(/[\{\}\\~\[\]\|€]/).size)
      end
    end

  end
end
