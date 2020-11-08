require "gettext_i18n_rails/tasks"

namespace :gettext do

  # Rewrite gettext filter to add vuejs file
  def files_to_translate
    folders = ["app", "lib", "config", locale_path].join(",")
    exts = %w[rb erb haml slim rhtml js jsx vue coffee handlebars hbs mustache].join(",")

    Dir.glob("{#{folders}}/**/*.{#{exts}}")
  end
end
