module Notifications
  module Msteams
    class SendService < BaseService
      def initialize(notification)
        @notification = notification
      end

      def call
        Faraday.post Rails.configuration.netam.dig(:notification, :msteams_webhook), payload.to_json
      end

      private

      def payload
        {
          "@type": "MessageCard",
          "@context": "http://schema.org/extensions",
          "summary": "NetAM Notif",
          "themeColor": "118811",
          "title": "Notification from NetAM",
          "sections": [
            {
              "activityTitle": "",
              "activitySubtitle": "",
              "activityText": ""
            },
            {
              "title": "#{@notification[:message]}",
              "facts": [
                {
                  "name": "#{@notification[:section][:network]}",
                  "value": "#{@notification[:section][:id]}"
                }
              ]
            }
          ]
        }
      end
    end
  end
end
