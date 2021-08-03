# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  prepend_before_action :check_initial_setup, only: [:new] # rubocop:disable Rails/LexicallyScopedActionFilter

  private

  def check_initial_setup
    return unless User.limit(1).count.zero?

    user = User.create!(email: Rails.configuration.netdiver.dig(:auth, :default_account_email), password: User.generate_random_password, admin: true)

    redirect_to edit_user_password_path(reset_password_token: user.generate_reset_token),
                notice: _('Please create a password for your new account.')
  end
end
