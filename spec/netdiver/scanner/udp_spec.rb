# frozen_string_literal: true

require 'rails_helper'

describe NetDiver::Scanner::Udp do
  it 'succeeds tcp scan on 0.fr.pool.ntp.org:123' do
    # expect(described_class.new('0.fr.pool.ntp.org', 123).scan!).to be_truthy
  end

  it 'failed tcp scan on 0.fr.pool.ntp.org:255' do
    expect(described_class.new('0.fr.pool.ntp.org', 255).scan!).not_to be_truthy
  end
end
