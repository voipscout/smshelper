module Smshelper
  module Api
    class Bulksms < Base
      base_uri 'http://bulksms.vsms.net:5567'

      def initialize(*args)
        config = args.shift
        add_query_options! :username => config.bulksms[:uname], :password => config.bulksms[:passwd]
        super
      end

      def send_message(message)
        if message.utf_8
          message.to_hex_be
          q = {:dca => '16bit'}
        else
          q = {:allow_concat_text_sms => '1', :concat_text_sms_max_parts => '5'}
        end

        options = {
          :msisdn => message.recipient,
          :message => message.text,
          :sender => message.sender}
        options = options.merge(@extra_options) unless @extra_options.nil?
        resp = (post 'eapi/submission/send_sms/2/2.0', :extra_query => options.merge(q)).split('|')
        process_response_code(resp.first) ? (@sent_message_ids << resp.last.strip; resp.last.strip) : (raise ErrorDuringSend, @response_code.bulksms(resp.first))
      end

      def get_balance
        {'Credits' => (post 'eapi/user/get_credits/1/1.1').split('|').last.chomp}
      end

      def get_status(message_id)
        options = {:batch_id => message_id}
        resp = (post 'eapi/status_reports/get_report/2/2.0', :extra_query => options)
        @sent_message_statuses[message_id] = []
        resp.split(/\n\n/).last.split(/\n/).each_with_index do |status, index|
          status = status.split('|').last
          @sent_message_statuses[message_id] << {"part #{index}" => @response_code.bulksms(status)}
        end
        {message_id => @sent_message_statuses[message_id]}
      end

      def get_callback_response(args = {})
          DeliveryReport.new(
                             :message_id => args['batch_id'],
                             :timestamp => Time.now,
                             :delivered => ((args['status'] == '11') ? true : false),
                             :status => @response_code.bulksms(args['status']),
                             :original_params => args
                             )
      end

      private
      def process_response_code(code)
        (code == '0') ? true : false
      end
    end
  end
end
