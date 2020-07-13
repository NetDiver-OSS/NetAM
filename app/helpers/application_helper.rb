module ApplicationHelper

  def page_title(*titles)
    @page_title ||= []

    @page_title.push(*titles.compact) if titles.any?

    # Segments are separated by middot
    @page_title.join(" · ")
    end

  def page_action(*actions)
    @page_action ||= []

    if actions.any?
      actions.each do |action|
        puts action.inspect
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
