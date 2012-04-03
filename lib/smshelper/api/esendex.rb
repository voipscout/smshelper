module Smshelper
  module Api
    class Esendex < Base
      INBOX_SERVICE_WSDL = 'https://www.esendex.com/secure/messenger/soap/InboxService.asmx?wsdl'
      SEND_SERVICE_WSDL = 'https://www.esendex.com/secure/messenger/soap/SendService.asmx?wsdl'
      ACCOUNT_SERVICE_WSDL = 'https://www.esendex.com/secure/messenger/soap/AccountService.asmx?wsdl'

      attr_reader :inbox
      def initialize(*args)
        config = args.shift
        @header = {
          "com:Username" => config.esendex[:uname],
          "com:Password" => config.esendex[:passwd],
          "com:Account" =>  config.esendex[:acc]}

        Savon.configure do |config|
          config.raise_errors = true
          config.log = false
          config.log_level = :error
          HTTPI.log = false
        end
        @inbox = Array.new
        super
      end

      def send_message(message)
        client = connect 'message'
        message.utf_8 ? (message_kind = 'Unicode') : (message_kind = 'Text')
        body = {
          "com:recipient" => message.recipient,
          "com:body" => message.text,
          "com:type" => message_kind,
          "com:originator" => message.sender}
        body = body.merge(@extra_options) unless @extra_options.nil?

        resp = client.request(:com, :send_message_full) {|soap| soap.header["com:MessengerHeader"] = @header; soap.body = body}
        (@sent_message_ids << resp.to_hash[:send_message_full_response][:send_message_full_result]).first
      end

      def get_inbox
        client = connect 'inbox'
        resp = client.request(:com, :get_messages) {|soap| soap.header["com:MessengerHeader"] = @header}
        @inbox = resp[:get_messages_response][:get_messages_result][:message]
      end

      def get_balance
        client = connect 'account'
        resp = client.request(:com, :get_message_limit) {|soap| soap.header["com:MessengerHeader"] = @header}
        {'Messages' => resp.to_hash[:get_message_limit_response][:get_message_limit_result].to_s}
      end

      def get_status(*message_id)
        message_id.flatten!

        client = connect 'message'
        message_id.each do |id|
          resp = client.request(:com, :get_message_status) {|soap| soap.header["com:MessengerHeader"] = @header; soap.body = {"com:id" => id.to_s}}
          @sent_message_statuses[id] = resp.to_hash[:get_message_status_response][:get_message_status_result]
        end
      end

      private
      def connect(service)
        case service
        when 'message'
          api SEND_SERVICE_WSDL
        when 'account'
          api ACCOUNT_SERVICE_WSDL
        when 'inbox'
          api INBOX_SERVICE_WSDL
        end
      end

      def api(service)
        client = Savon::Client.new(service)
        #http://jira.codehaus.org/browse/JRUBY-5529 - jruby-openssl in --1.9 jruby mode
        client.http.auth.ssl.verify_mode=(:none)
        client
      end

    end #class Esendex
  end #module Api
end #module Smshelper
