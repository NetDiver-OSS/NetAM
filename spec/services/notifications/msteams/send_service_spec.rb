# frozen_string_literal: true

require 'rails_helper'

describe Notifications::Msteams::SendService do
  let(:notification_object) do
    {
      section: {
        id: 42,
        network: '172.16.1.0'
      },
      message: 'Scan finished !'
    }
  end

  it 'should send notification when MSTeams is enabled' do
    Rails.configuration.netam[:notification][:msteams_webhook] = 'https://outlook.office.com/webhook/XXXX/XXXX/XXXX/XXXX'
    expect { described_class.call(notification_object) }.not_to raise_error
    expect { Notifications::SendService.call(notification_object) }.not_to raise_error
  end

  it 'should failed when MSTeams is disabled' do
    Rails.configuration.netam[:notification][:msteams_webhook] = nil
    expect { described_class.call(notification_object) }.to raise_error(StandardError)
    expect(Notifications::SendService.call(notification_object)).to be_nil
  end
end
