# -*- coding: utf-8 -*-
module Smshelper
  module Api
    class Base
      include APISmith::Client
      include Log4r

      attr_reader :sent_message_ids, :sent_message_statuses
      attr_accessor :extra_options
      def initialize(*args)
        @log = Logger.new "#{self.class.name}"
        @log.outputters = Outputter.stdout
        @log.level = DEBUG #ERROR

        @sent_message_ids, @sent_message_statuses = Array.new, Hash.new
        @response_code = ResponseCodes.instance
        @extra_options = args.shift
      end
    end
  end
end
