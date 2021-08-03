# frozen_string_literal: true

require 'gettext_i18n_rails/tasks'

namespace :gettext do
  # Rewrite gettext filter to add vueJS file
  def files_to_translate
    folders = ['app', 'lib', 'config', locale_path].join(',')
    exts = %w[rb erb haml slim rhtml js jsx vue coffee handlebars hbs mustache].join(',')

    Dir.glob("{#{folders}}/**/*.{#{exts}}")
  end

  desc 'Regenerate netdiver.pot file'
  task :regenerate do
    pot_file = 'locale/netdiver.pot'
    FileUtils.rm_f pot_file

    Rake::Task['gettext:find'].invoke

    # leave only the required changes.
    unless system('git', '-c', 'core.hooksPath=/dev/null', 'checkout', '--', 'locale/*/netdiver.po') # rubocop:disable Style/IfUnlessModifier
      raise 'failed to cleanup generated locale/*/netdiver.po files'
    end

    # Remove timestamps from the pot file
    pot_content = File.read pot_file
    pot_content.gsub!(/^"POT?-(?:Creation|Revision)-Date:.*\n/, '')
    File.write pot_file, pot_content
  end
end
