# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "smshelper"
  s.version = "0.4.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Voip Scout"]
  s.date = "2012-05-26"
  s.description = "works www.bulksms.com, www.webtext.com, www.clickatell.com, www.textmagic.com, www.smstrade.eu, www.esendex.com, www.mediaburst.co.uk, www.nexmo.com, www.vianett.com, www.traitel.com.au, www.my-cool-sms.com, www.aql.com"
  s.email = "voipscout@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/smshelper.rb",
    "lib/smshelper/api.rb",
    "lib/smshelper/api/aql.rb",
    "lib/smshelper/api/base.rb",
    "lib/smshelper/api/bulksms.rb",
    "lib/smshelper/api/clickatell.rb",
    "lib/smshelper/api/esendex.rb",
    "lib/smshelper/api/mediaburst.rb",
    "lib/smshelper/api/mycoolsms.rb",
    "lib/smshelper/api/nexmo.rb",
    "lib/smshelper/api/response_codes.rb",
    "lib/smshelper/api/routomessaging.rb",
    "lib/smshelper/api/smstrade.rb",
    "lib/smshelper/api/smswarehouse.rb",
    "lib/smshelper/api/textmagic.rb",
    "lib/smshelper/api/traitel.rb",
    "lib/smshelper/api/txtnation.rb",
    "lib/smshelper/api/vianett.rb",
    "lib/smshelper/api/webtext.rb",
    "lib/smshelper/config.rb",
    "lib/smshelper/languagetools.rb",
    "lib/smshelper/languagetools/languagetools.rb",
    "lib/smshelper/message.rb",
    "smshelper.gemspec",
    "spec/smshelper_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/voipscout/smshelper"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "send sms with: www.bulksms.com, www.webtext.com, www.clickatell.com, www.textmagic.com, www.smstrade.eu, www.esendex.com, www.mediaburst.co.uk, www.nexmo.com, www.vianett.com, www.traitel.com.au, www.my-cool-sms.com, www.aql.com"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<api_smith>, [">= 0"])
      s.add_runtime_dependency(%q<savon>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<textmagic>, [">= 0"])
      s.add_runtime_dependency(%q<uuid>, [">= 0"])
      s.add_runtime_dependency(%q<digest-crc>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<api_smith>, [">= 0"])
      s.add_dependency(%q<savon>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<textmagic>, [">= 0"])
      s.add_dependency(%q<uuid>, [">= 0"])
      s.add_dependency(%q<digest-crc>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<api_smith>, [">= 0"])
    s.add_dependency(%q<savon>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<textmagic>, [">= 0"])
    s.add_dependency(%q<uuid>, [">= 0"])
    s.add_dependency(%q<digest-crc>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

