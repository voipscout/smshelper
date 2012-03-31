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
      end
    end
  end
end
