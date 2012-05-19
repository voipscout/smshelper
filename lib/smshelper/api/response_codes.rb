# -*- coding: utf-8 -*-
module Smshelper
  module Api
    class ResponseCodes
      BULKSMS = {
        '0' => 'In progress',
        '1' => 'Scheduled',
        '10' => 'Delivered upstream',
        '11' => 'Delivered to mobile',
        '12' => 'Delivered upstream unacknowledged',
        '22' => 'Internal fatal error',
        '23' => 'Authentication failure',
        '24' => 'Data validation failed',
        '25' => 'You do not have sufficient credits',
        '26' => 'Upstream credits not available',
        '27' => 'You have exceeded your daily quota',
        '28' => 'Upstream quota exceeded',
        '29' => 'Message sending cancelled',
        '31' => 'Unroutable',
        '32' => 'Blocked',
        '33' => 'Failed: censored',
        '40' => 'Temporarily unavailable',
        '50' => 'Delivery failed - generic failure',
        '51' => 'Delivery to phone failed',
        '52' => 'Delivery to network failed',
        '53' => 'Message expired',
        '54' => 'Failed on remote network',
        '56' => 'Failed: remotely censored',
        '57' => 'Failed due to fault on handset',
        '60' => 'Transient upstream failure',
        '61' => 'Upstream status update',
        '62' => 'Upstream cancel failed',
        '63' => 'Queued for retry after temporary failure delivering',
        '64' => 'Queued for retry after temporary failure delivering, due to fault on handset',
        '70' => 'Unknown upstream status',
        '201' => 'Maximum batch size exceeded'}

      WEBTEXT = {
        '000' => 'Success. Message accepted for delivery',
        '101' => 'Missing parameter: api_id',
        '102' => 'Missing parameter: api_pwd',
        '103' => 'Missing parameter: txt',
        '104' => 'Missing parameter: dest',
        '105' => 'Missing parameter: msgid',
        '106' => 'Missing parameter: receipt_url',
        '107' => 'Missing parameter: receipt_email',
        '108' => 'Invalid value for parameter: hex',
        '109' => 'Missing parameter: hex (unicode parameter has been presented, but no hex value)',
        '110' => 'Missing parameter: si_txt',
        '111' => 'Missing parameter: si_url',
        '112' => 'Missing parameter: group_name',
        '113' => 'Missing parameter: group_alias',
        '114' => 'Missing parameter: contact_num',
        '115' => 'Missing parameter: remove_num',
        '199' => 'Insufficient Credit',
        '201' => 'Authentication Failure',
        '202' => 'IP Restriction – an attempt has been made to send from an unauthorised IP address',
        '203' => 'Invalid value for parameter: dest',
        '204' => 'Invalid value for parameter: api_pwd',
        '205' => 'Invalid value for parameter: api_id',
        '206' => 'Invalid value for parameter: delivery_time',
        '207' => 'Invalid date specified for delivery_time',
        '208' => 'Invalid value for parameter: delivery_delta',
        '209' => 'Invalid value for parameter: receipt',
        '210' => 'Invalid value for parameter: msgid',
        '211' => 'Invalid value for parameter: tag',
        '212' => 'Invalid value for parameter: si_txt',
        '213' => 'Invalid value for parameter: si_url',
        '214' => 'Invalid value for parameter: group_name',
        '215' => 'Invalid value for parameter: group_alias',
        '216' => 'Invalid value for parameter: contact_num',
        '217' => 'Invalid value for parameter: remove_num',
        '401' => 'Not a contact',
        '402' => 'Invalid value for parameter: group_alias'}

      CLICKATELL = {
        '001' => 'Message unknown',
        '002' => 'Message queued',
        '003' => 'Delivered to gateway',
        '004' => 'Received by recipient',
        '005' => 'Error with message',
        '006' => 'User cancelled message delivery',
        '007' => 'Error delivering message',
        '008' => 'OK',
        '009' => 'Routing error',
        '010' => 'Message expired',
        '011' => 'Message queued for later delivery',
        '012' => 'Out of credit',
        '014' => 'Maximum MT limit exceeded'}

      SMSTRADE = {
        '10' => 'Receiver number not valid',
        '20' => 'Sender number not valid',
        '30' => 'Message text not valid',
        '31' => 'Message type not valid',
        '40' => 'SMS route not valid',
        '50' => 'Identification failed',
        '60' => 'Not enough balance in account',
        '70' => 'Network does not support the route',
        '71' => 'Feature is not possible by the route',
        '80' => 'Handover to SMSC failed',
        '100' => 'SMS has been sent successfully'}

      MEDIABURST = {
        '1' => 'Internal Error',
        '2' => 'Invalid Username Or Password',
        '3' => 'Insufficient Credits Available',
        '4' => 'Authentication Failure',
        '5' => 'Invalid MsgType',
        '6' => "‘To’ Parameter Not Specified",
        '7' => "‘Content’ Parameter Not Specified",
        '8' => "‘MessageID’ Parameter Not specified",
        '9' => "Unknown ‘MessageID’",
        '10' => "Invalid ‘To’ Parameter",
        '11' => "Invalid ‘From’ Parameter",
        '12' => 'Max Message Parts Exceeded',
        '13' => 'Cannot Route Message',
        '14' => 'Message Expired',
        '15' => 'No route defined for this number',
        '16' => "‘URL’ parameter not set",
        '17' => 'Invalid Source IP',
        '18' => "‘UDH’ Parameter Not Specified",
        '19' => "Invalid ‘ServType’ Parameter",
        '20' => "Invalid ‘ExpiryTime’ Parameter",
        '25' => 'Duplicate ClientId received',
        '26' => 'Internal Error',
        '27' => "Invalid ‘TimeStamp’ Parameter",
        '28' => "Invalid ‘AbsExpiry’ Parameter",
        '29' => "Invalid ‘DlrType’ Parameter",
        '31' => "Invalid ‘Concat’ Parameter",
        '32' => "Invalid ‘UniqueId’ Parameter",
        '33' => "Invalid ‘ClientId’ Parameter",
        '39' => "Invalid character in ‘Content’ parameter",
        '40' => 'Invalid TextPayload',
        '41' => 'Invalid HexPayload',
        '42' => 'Invalid Base64Payload',
        '43' => 'Missing content type',
        '44' => 'Missing ID',
        '45' => 'MMS Message too large',
        '46' => 'Invalid Payload ID',
        '47' => 'Duplicate Payload ID',
        '48' => 'No payload on MMS',
        '49' => "Duplicate ‘filename’ Attribute on Payload",
        '50' => "‘ItemId’ Parameter Not Specified",
        '51' => "Invalid ‘ItemId’ Parameter",
        '52' => 'Unable to generate filename for Content-Type',
        '53' => "Invalid ‘InvalidCharAction’ Parameter",
        '54' => "Invalid ‘DlrEnroute’ Parameter",
        '55' => "Invalid ‘Truncate’ Parameter",
        '56' => "Invalid ‘Long’ Parameter",
        '100' => 'Internal Error',
        '101' => 'Internal Error',
        '102' => 'Invalid XML',
        '103' => 'XML Document does not validate',
        '300' => 'Client ID too long',
        '305' => 'Query throttling rate exceeded'}

      NEXMO = {
        '0' => 'Success',
        '1' => 'Throttled',
        '2' => 'Missing params',
        '3' => 'Invalid params',
        '4' => 'Invalid credentials',
        '5' => 'Internal error',
        '6' => 'Invalid message',
        '7' => 'Number barred',
        '8' => 'Partner account barred',
        '9' => 'Partner quota exceeded',
        '10' => 'Too many existing binds',
        '11' => 'Account not enabled for REST',
        '12' => 'Message too long',
        '15' => 'Invalid sender address',
        '16' => 'Invalid TTL'}

      AQL = {}

      def webtext(code)
        WEBTEXT[code]
      end

      def bulksms(code)
        BULKSMS[code]
      end

      def clickatell(code)
        CLICKATELL[code]
      end

      def smstrade(code)
        SMSTRADE[code]
      end

      def mediaburst(code)
        MEDIABURST[code]
      end

      def nexmo(code)
        NEXMO[code]
      end

    end
  end
end
