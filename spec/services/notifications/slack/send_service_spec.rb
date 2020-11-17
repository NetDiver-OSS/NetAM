# frozen_string_literal: true

require 'rails_helper'

describe Notifications::Slack::SendService do
  let(:notification_object) do
    {
      section: {
        id: 42,
        network: '172.16.1.0'
      },
      message: 'Scan finished !'
    }
  end

  it 'should send notification when Slack is enabled' do
    Rails.configuration.netam[:notification][:slack_webhook] = 'https://hooks.slack.com/services/XXXX/XXXX/XXXX'
    expect { Notifications::Slack::SendService.call(notification_object) }.not_to raise_error
    expect { Notifications::SendService.call(notification_object) }.not_to raise_error
  end

  it 'should failed when Slack is disabled' do
    Rails.configuration.netam[:notification][:slack_webhook] = nil
    expect { Notifications::Slack::SendService.call(notification_object) }.to raise_error
    expect(Notifications::SendService.call(notification_object)).to be_nil
  end
end
