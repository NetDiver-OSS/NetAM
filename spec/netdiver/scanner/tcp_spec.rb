# frozen_string_literal: true

require 'rails_helper'

describe NetDiver::Scanner::Tcp do
  it 'succeeds tcp scan on github.com:443' do
    expect(described_class.new('github.com', 443).scan!).to be_truthy
  end

  it 'failed tcp scan on github.com:255' do
    expect(described_class.new('github.com', 255).scan!).not_to be_truthy
  end
end
