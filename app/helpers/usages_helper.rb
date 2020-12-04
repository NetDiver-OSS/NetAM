# frozen_string_literal: true

module UsagesHelper
  def usage_color(usage)
    case usage
    when 'locked'
      'blue-500'
    when 'actived'
      'green-500'
    when 'down'
      'red-500'
    when 'dhcp'
      'purple-500'
    else
      'gray-800'
    end
  end

  def usage_icon(usage)
    case usage
    when 'locked'
      icon('lock')
    when 'actived'
      icon('check2')
    when 'down'
      icon('x')
    when 'dhcp'
      icon('shuffle')
    else
      icon('question')
    end
  end
end
