module Smshelper
  class Config

    def initialize(interfaces = {})
      interfaces.each do |interface, config|
        self.class.send(:define_method, interface) do
          config
        end
      end
    end
  end
end
