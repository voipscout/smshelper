Smshelper
---------

__THE lib for SMS-MT / HLR-Lookups.__

One day i was asked to connect a crm to correspond in SMS with call
center customers. Chose at random one of the operators, wrote a few
lines of code and there it was - SMS inbound/outbound.

> "Some of our messages aren't being delivered on time, some are being
> lost altogether, some arrive multiple times, some arrive after more
> then 24 hours from being sent"

> _--Your faithful customer_

I kept adding operators and here are the results...

__Currently supported:__

* __Unicode:__  across all operators
<table>
    <tr>
        <th>Operator</th><th>#send_message</th><th>#get_balance</th><th>#get_status</th><th>#get_callback_response</th><th>#hlr_lookup</th>
    </tr>
    <tr>
        <td>Aql</td><td>X</td><td>X</td><td>_</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Bulksms</td><td>X</td><td>X</td><td>X</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Clickatell</td><td>X</td><td>X</td><td>X</td><td>_</td><td>_</td>
    </tr>
    <tr>
        <td>Esendex</td><td>X</td><td>X</td><td>X</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Mediaburst</td><td>X</td><td>X</td><td>_</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Mycoolsms</td><td>X</td><td>X</td><td>_</td><td>X</td><td>X</td>
    </tr>
    <tr>
        <td>Nexmo</td><td>X</td><td>X</td><td>_</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Routomessaging</td><td>X</td><td>X</td><td>_</td><td>X</td><td>X**</td>
    </tr>
    <tr>
        <td>Smstrade</td><td>X</td><td>X</td><td>_</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Textmagic</td><td>X</td><td>X</td><td>_</td><td>X</td><td>_</td>
    </tr>
    <tr>
        <td>Traitel</td><td>X</td><td>X</td><td>_</td><td>_</td><td>_</td>
    </tr>
    <tr>
        <td>Vianett</td><td>X</td><td>X</td><td>_</td><td>X</td><td>X</td>
    </tr>
    <tr>
        <td>Webtext</td><td>X</td><td>X</td><td>_</td><td>_</td><td>_</td>
    </tr>
</table>

<!-- <iframe width='561' height='300' frameborder='0' src='https://docs.google.com/spreadsheet/pub?key=0AvGdwcIrVUI9dDNOUkE5Mlo0VnJEcmJaYlRJRkg1aEE&single=true&gid=0&output=html&widget=true'></iframe> -->
** _Does_ __NOT__ _provide handset network status, so you can't check if a
   subscriber is in reception zone with a switched-on handset._

__Installation__

gem install smshelper

__Usage__

```ruby
require 'smshelper'
config = Smshelper::Config.new(
                               :webtext => {:uname => '', :passwd => ''},
                               :bulksms => {:uname => '', :passwd => ''},
                               :clickatell => {:api_key => '',:uname => '', :passwd => ''},
                               :textmagic => {:uname => '', :passwd => ''},
                               :smstrade => {:api_key => ''},
                               :esendex => {:uname => '', :passwd => '', :acc => ''},
                               :mediaburst => {:uname => '', :passwd => ''},
                               :nexmo => {:uname => '', :passwd => ''}
                               )

service0 = Smshelper::Api::Bulksms.new config
service1 = Smshelper::Api::Webtext.new config
service2 = Smshelper::Api::Clickatell.new config
service3 = Smshelper::Api::Textmagic.new config
service4 = Smshelper::Api::Smstrade.new config, :route => 'gold'
service5 = Smshelper::Api::Esendex.new config, 'com:validityperiod' => '1'
service6 = Smshelper::Api::MediaBurst.new config
service7 = Smshelper::Api::Nexmo.new config, :ttl => '60000'

message = Smshelper::Message.new(
                                 :recipient => '14128765432',
                                 :text => "The balance on
                                 #{serviceX.class.name} is
                                 #{serviceX.get_balance}",
                                 :sender => '33765432132')

serviceX.send_message message

```

### Is It "Production Ready™"?

Most likely not, there are no tests yet and the API is going
to change a bit until v1.0.0 release

__TODO:__

* TESTs
* introduce plugin infrastructure
* handle sms of any size (_currently smshelper tries to use concat
  setts, operator permitting_)
* add support for www.totext.net, www.world-text.com, www.mpulse.eu, www.clicksms.co.uk, www.tellustalk.com, www.tm4b.com, www.txtnation.com, www.smsextrapro.com, www.truesenses.com

### I welcome pull requests!
