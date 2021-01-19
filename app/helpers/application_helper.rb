# frozen_string_literal: true

module ApplicationHelper
  def fa_icon(type, name, size: 16)
    content_tag('fa-icon', '', { type: type, name: name, size: size, class: 'inline-flex' })
  end

  def fa_icon_with_text(type, name, text)
    "#{fa_icon(type, name)} #{text}".html_safe # rubocop:disable Rails/OutputSafety
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
          link_to(action[:icon].html_safe, action[:path], class: 'btn', method: action[:method] || 'get') # rubocop:disable Rails/OutputSafety
        )
      end
    end

    @page_action.join(' ')
  end

  def dark_mode?
    cookies['theme'] == 'dark'
  end
end
