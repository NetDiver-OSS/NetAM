require 'rails_helper'

RSpec.describe UsagesHelper, type: :helper do
  describe '#usage_color' do
    it 'should return green if usage is locked' do
      expect(helper.usage_color('locked')).to eq('blue')
    end
    it 'should return green if usage is actived' do
      expect(helper.usage_color('actived')).to eq('green')
    end
    it 'should return red if usage is down' do
      expect(helper.usage_color('down')).to eq('red')
    end
    it 'should return purple if usage is dhcp' do
      expect(helper.usage_color('dhcp')).to eq('purple')
    end
    it 'should return grey by default' do
      expect(helper.usage_color('invalid_state')).to eq('gray')
    end
  end

  describe '#usage_icon' do
    it 'should return fa-lock is loacked' do
      expect(helper.usage_icon('locked')).to eq('<i class="fas fa-lock"></i>')
    end
    it 'should return fa-check-circle is actived' do
      expect(helper.usage_icon('actived')).to eq('<i class="fas fa-check-circle"></i>')
    end
    it 'should return fa-times-circle is down' do
      expect(helper.usage_icon('down')).to eq('<i class="fas fa-times-circle"></i>')
    end
    it 'should return fa-random is dhcp' do
      expect(helper.usage_icon('dhcp')).to eq('<i class="fas fa-random"></i>')
    end
    it 'should return fa-question-circle by default' do
      expect(helper.usage_icon('qdsgqsdgdsq')).to eq('<i class="fas fa-question-circle"></i>')
    end
  end
end
