module Notifications
  class SendService < BaseService
    def initialize(notification_object) # rubocop:disable Lint/MissingSuper
      @notification_object = notification_object
    end

    def call
      Notifications::Slack::SendService.call(@notification_object) if Rails.configuration.netam.dig(:notification, :slack_webhook).present?
      Notifications::Msteams::SendService.call(@notification_object) if Rails.configuration.netam.dig(:notification, :msteams_webhook).present?
      Notifications::Mail::SendService.call(@notification_object) if Rails.configuration.netam.dig(:notification, :mail, :host).present?
    end
  end
end
