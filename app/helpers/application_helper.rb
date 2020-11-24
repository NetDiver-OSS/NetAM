# frozen_string_literal: true

module ApplicationHelper
  def icon(name, size = 16)
    icon = <<~SVG
      <svg class="bi" width="#{size}" height="#{size}" fill="currentColor">
        <use xlink:href="#{asset_pack_url('media/bootstrap-icons/bootstrap-icons.svg')}##{name}"/>
      </svg>
    SVG

    icon.html_safe # rubocop:disable Rails/OutputSafety
  end

  def icon_with_text(name, text, size = 16)
    "#{icon(name, size)} #{text}".html_safe # rubocop:disable Rails/OutputSafety
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
          link_to(action[:icon].html_safe, action[:path], class: 'btn btn-sm btn-outline-secondary btn-flat', method: action[:method] || 'get') # rubocop:disable Rails/OutputSafety
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
