# frozen_string_literal: true

module Notifications
  module Mail
    class SendService < BaseService
      def initialize(notification) # rubocop:disable Lint/MissingSuper
        @notification = notification
      end

      def call
        message_content = "From: #{Rails.configuration.netam.dig(:notification, :mail, :from)}\n"
        message_content << "MIME-Version: 1.0\n"
        message_content << "Content-Type: text/html\n"
        message_content << "Subject: [NetAM] Scan finished\n"
        message_body = "#{@notification[:message]} <br/>"
        message_body << "Section: #{@notification[:section][:network]} (#{@notification[:section][:id]})<br/><br/>"

        auth_type = Rails.configuration.netam.dig(:notification, :mail, :type).present? ? Rails.configuration.netam.dig(:notification, :mail, :type).to_sym : nil
        smtp = Net::SMTP.new(
          Rails.configuration.netam.dig(:notification, :mail, :host),
          Rails.configuration.netam.dig(:notification, :mail, :port)
        ).start(
          Rails.configuration.netam.dig(:notification, :mail, :helo),
          Rails.configuration.netam.dig(:notification, :mail, :user),
          Rails.configuration.netam.dig(:notification, :mail, :pass),
          auth_type
        )
        smtp.enable_ssl unless Rails.configuration.netam.dig(:notification, :mail, :ssl).nil?

        Rails.configuration.netam.dig(:notification, :mail, :to).each do |mail_to|
          message_content << "To: #{mail_to}\n"
          message = "#{message_content}\n#{message_body}"
          begin
            smtp.send_message message, Rails.configuration.netam.dig(:notification, :mail, :from), mail_to
          rescue StandardError => e
            Rails.logger.error("Unable to send email with exception : #{e.message}")
          end
        end
      end
    end
  end
end
