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

  it 'should send notification when Slack is enabled' do
    Rails.configuration.netam[:notification][:msteams_webhook] = "https://outlook.office.com/webhook/XXXX/XXXX/XXXX/XXXX"
    expect { Notifications::Msteams::SendService.call(notification_object) }.not_to raise_error
    expect { Notifications::SendService.call(notification_object) }.not_to raise_error
  end

  it 'should failed when Slack is disabled' do
    Rails.configuration.netam[:notification][:slack_webhook] = nil
    expect { Notifications::Msteams::SendService.call(notification_object) }.to raise_error
    expect(Notifications::SendService.call(notification_object)).to be_nil
  end
end
