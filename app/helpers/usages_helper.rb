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
      '<i class="fas fa-lock"></i>'.html_safe
    when 'actived'
      '<i class="fas fa-check-circle"></i>'.html_safe
    when 'down'
      '<i class="fas fa-times-circle"></i>'.html_safe
    when 'dhcp'
      '<i class="fas fa-random"></i>'.html_safe
    else
      '<i class="fas fa-question-circle"></i>'.html_safe
    end
  end
end
