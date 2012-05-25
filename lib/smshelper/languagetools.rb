module Smshelper
  module Languagetools
    path = (File.dirname File.expand_path(__FILE__))

    autoload :Charset, "#{path}/languagetools/languagetools"
  end
end
