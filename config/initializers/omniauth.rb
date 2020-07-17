Rails.application.config.assets.precompile += %w[omniauth_form.css]

module OmniAuth
  class Form
    protected

    def css
      h = ActionController::Base.helpers
      h.stylesheet_link_tag("omniauth_form", media: "all")
    end
  end
end
