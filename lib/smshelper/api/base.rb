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
              self.class.attribute(:uuid, String, :default => UUID.generate)
              self.class.attribute(:service, String, :default => self.class.name.split('::')[2])
            end

          end
        end
      end

      # def class_factory(*names)
      #   names.each do |name|
      #     klass = self.class.const_set(name, Class.new)
      #     klass.class_eval do
      #       attr_reader :uuid, :service

      #       define_method(:initialize) do |args = {}|
      #         args.each do |k,v|
      #           unless k.to_s =~ (/splat/ || /captures/)
      #             self.class.send(:define_method, k.to_sym) {v}
      #             instance_variable_set("@"+k.to_s, v)
      #           end
      #         end
      #         instance_variable_set("@uuid", UUID.generate)
      #         instance_variable_set("@service", self.class.name.split('::')[2])
      #       end

      #       #TODO: Find out why is this needed!
      #       define_method("_dump".to_sym) do |level|
      #         self.to_yaml
      #       end

      #       def self._load(str)
      #         YAML.load str
      #       end

      #     end
      #   end
      # end

    end # class Base
  end # module Api
end # module Smshelper
