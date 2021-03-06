# -*- coding: utf-8 -*-
module Smshelper
  module Api
    class Base
      include APISmith::Client

      attr_reader :sent_message_ids, :sent_message_statuses
      attr_accessor :extra_options
      def initialize(*args)
        @sent_message_ids, @sent_message_statuses = Array.new, Hash.new
        @response_code = ResponseCodes.new
        @extra_options = (args.empty? ? {} : args.shift)
        @uuid = UUID.new
        class_factory 'DeliveryReport', 'InboundMessage', 'UnknownReply', 'HlrReport'
      end

      protected
      def class_factory(*names)
        names.each do |name|
          unless self.class.const_defined?(name)
            klass = self.class.const_set(name, Class.new)
            klass.class_eval do
              include Virtus

              define_method(:initialize) do |args = {}|
                args.each do |k,v|
                  # Sinatra params has splat, captures
                  unless k.to_s =~ (/splat/ || /captures/)
                    self.class.attribute(k, v.class, :default => v)
                  end
                end
                self.class.attribute(:uuid, String, :default => UUID.generate) unless args[:uuid]
                self.class.attribute(:service, String, :default => self.class.name.split('::')[2])
              end

              # I was lazy to lookup which method takes precedence in
              # what situation, hence:
              def _dump(level)
                attributes.to_yaml
              end

              def marshal_dump
                attributes.to_yaml
              end

              def marshal_load(str)
                self.class.new(YAML.load(str))
              end

              def self._load(str)
                self.class.new(YAML.load(str))
              end

            end
          end
        end
      end
    end # class Base
  end # module Api
end # module Smshelper
