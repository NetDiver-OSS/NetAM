module ApplicationHelper
  def fa_icon(icon_class)
    tag(:i, class: icon_class)
  end

  def fa_icon_with_text(icon_class, text)
    sanitize "#{fa_icon(icon_class)} #{text}"
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
          link_to(sanitize(action[:icon]), action[:path], class: 'btn btn-secondary btn-flat', method: action[:method] || 'get')
        )
      end
    end

    @page_action.join(' ')
  end

  def dark_mode?
    cookies['dark_mode'] == 'true'
  end

  def dark_mode_class
    dark_mode? ? 'bg-dark text-white' : ''
  end
end
