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
        @extra_options = args.shift
        @uuid = UUID.new
        class_factory 'DeliveryReport', 'InboundMessage', 'UnknownReply'
      end

      protected
      def class_factory(*names)
        names.each do |name|
          klass = self.class.const_set(name, Class.new)
          klass.class_eval do
            attr_reader :uuid, :service

            define_method(:initialize) do |args = {}|
              args.each do |k,v|
                unless k.to_s =~ (/splat/ || /captures/)
                  self.class.send(:define_method, k.to_sym) {v}
                  instance_variable_set("@"+k.to_s, v)
                end
              end
              instance_variable_set("@uuid", UUID.generate)
              instance_variable_set("@service", self.class.name.split('::')[2])
            end

            # define_method("marshal_dump".to_sym) do
            #   self.to_yaml
            # end

            # define_method("marshal_load".to_sym) do |yaml|
            #   YAML.load(yaml)
            # end

          end
        end
      end
    end
  end
end
