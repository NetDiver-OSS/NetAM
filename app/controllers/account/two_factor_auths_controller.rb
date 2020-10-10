module Account
  class TwoFactorAuthsController < ApplicationController
    # POST /two_factor_auths
    def create
      unless current_user.otp_required_for_login
        current_user.otp_required_for_login = true
        current_user.otp_secret = User.generate_otp_secret
        @codes = current_user.generate_otp_backup_codes!
        current_user.save!
      end

      render :index
    end

    # DELETE /two_factor_auths
    def destroy
      current_user.otp_required_for_login = false
      current_user.save!

      render :index
    end
  end
end