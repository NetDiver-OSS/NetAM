# frozen_string_literal: true

module Notifications
  module Msteams
    class SendService < BaseService
      def initialize(notification) # rubocop:disable Lint/MissingSuper
        @notification = notification
      end

      def call
        Faraday.post Rails.configuration.netdiver.dig(:notification, :msteams_webhook), payload.to_json, 'Content-Type' => 'application/json'
      end

      private

      def payload
        {
          '@type': 'MessageCard',
          '@context': 'http://schema.org/extensions',
          summary: 'NetDiver Notif',
          themeColor: '118811',
          title: 'Notification from NetDiver',
          sections: [
            {
              activityTitle: '',
              activitySubtitle: '',
              activityText: ''
            },
            {
              title: @notification[:message],
              facts: [
                {
                  name: @notification[:section][:network].to_s,
                  value: @notification[:section][:id]
                }
              ]
            }
          ]
        }
      end
    end
  end
end
