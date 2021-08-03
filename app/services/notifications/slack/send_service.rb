# frozen_string_literal: true

module Notifications
  module Slack
    class SendService < BaseService
      def initialize(notification) # rubocop:disable Lint/MissingSuper
        @notification = notification
      end

      def call
        Faraday.post Rails.configuration.netdiver.dig(:notification, :slack_webhook), payload.to_json
      end

      private

      def payload
        {
          blocks: [
            {
              type: 'section',
              text: {
                type: 'mrkdwn',
                text: @notification[:message]
              }
            },
            {
              type: 'section',
              text: {
                type: 'mrkdwn',
                text: "*Section ID:* #{@notification[:section][:id]}\n*Section Network:* #{@notification[:section][:network]}"
              }
            }
          ]
        }
      end
    end
  end
end
