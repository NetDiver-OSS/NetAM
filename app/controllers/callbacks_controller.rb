class CallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def ldap
    ldap_return = request.env["omniauth.auth"]["extra"]["raw_info"]
    email = ldap_return.mail.first.to_s

    if (@user = User.find_by_email(email))
      sign_in_and_redirect @user
    else
      @user = User.create(
        email: email,
        password: User.generate_random_password
      )
      sign_in_and_redirect @user
    end
  end
end
