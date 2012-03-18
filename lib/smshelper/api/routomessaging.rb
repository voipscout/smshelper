#TODO: different base_uri's for get_balance and send_message
module SmsTools
  class Routomessaging < Base
    base_uri "http://smsc5.routotelecom.com"

    def initialize(*args)
      @uname, @passwd = args.shift, args.shift
    end

    #send_message TO, MESSAGE, FROM
    def send_message(*args)
      add_query_options! :user => @uname, :pass => @passwd, :type => 'LongSMS'

      (post 'SMSsend', :extra_query => {
         :number => args.shift,
         :message => args.shift,
         :ownnum => args.shift})
    end

    def get_balance
      # TODO: change base_uri before executing the query
      # self.base_uri 'http://smsc6.routotelecom.com'
      add_query_options! :username => @uname, :password => @passwd, :base_uri => 'http://smsc6.routotelecom.com'

      (post 'balance.php').to_s.chomp
    end
  end
end

#
