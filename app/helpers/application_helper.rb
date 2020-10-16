module ApplicationHelper
  def fa_icon_with_text(icon_class, text)
    "<i class=\"#{icon_class}\"></i> #{text}".html_safe
  end

  def page_title(*titles)
    @page_title ||= []

    @page_title.push(*titles.compact) if titles.any?

    # Segments are separated by middot
    @page_title.join(' · ')
  end

  def page_action(*actions)
    @page_action ||= []

    if actions.any?
      actions.each do |action|
        @page_action.push(
          link_to(action[:icon].to_s.html_safe, action[:path], class: 'btn btn-secondary btn-flat', method: action[:method] || 'get')
        )
      end
    end

    @page_action.join(' ').html_safe
  end

  def dark_mode?
    cookies['dark_mode'] == 'true'
  end
end
