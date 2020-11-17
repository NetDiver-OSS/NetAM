# frozen_string_literal: true

class CallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def ldap
    ldap_return = request.env['omniauth.auth']['extra']['raw_info']
    email = ldap_return.mail.first.to_s

    unless (@user = User.find_by(email: email))
      @user = User.create(
        email: email,
        password: User.generate_random_password
      )
    end

    sign_in_and_redirect @user
  end
end
