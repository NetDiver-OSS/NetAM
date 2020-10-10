module Account
  class TwoFactorAuthsController < ApplicationController
    # GET /
    def index
      generate_totp_qrcode
    end

    # POST /two_factor_auths
    def create
      if current_user.otp_secret.nil?
        current_user.otp_secret = User.generate_otp_secret
        current_user.save!
      end

      generate_totp_qrcode
      render :index
    end

    # POST /two_factor_auths/validate
    def validate
      if current_user.otp_pending?
        validate_code = current_user.validate_and_consume_otp!(params[:otp_attempt])

        if validate_code
          current_user.otp_required_for_login = true
          @codes = current_user.generate_otp_backup_codes!
          current_user.save!
          flash[:notice] = 'Successfully validated OTP'
        else
          flash[:alert] = 'OTP validation failed !'
        end
      end

      redirect_to account_two_factor_auths_url
    end

    # DELETE /two_factor_auths
    def destroy
      current_user.otp_secret = nil
      current_user.otp_required_for_login = false
      current_user.save!

      render :index
    end

    private

    def generate_totp_qrcode
      uri = current_user.otp_provisioning_uri("NetAM:#{current_user.email}", issuer: 'NetAM')
      pp uri
      @qrcode = RQRCode::QRCode.new(uri).as_svg(standalone: true, module_size: 5)
    end
  end
end
