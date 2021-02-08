# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :omniauthable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :two_factor_authenticatable, :two_factor_backupable,
         omniauth_providers: [:ldap], otp_secret_encryption_key: Rails.configuration.netam.dig(:otp, :secret),
         otp_number_of_backup_codes: 10

  default_scope -> { order(id: :asc) }
  has_many :permissions, dependent: :destroy

  validates_associated :permissions

  scope :admins, -> { where(admin: true) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token(256)
    end
  end

  def self.generate_random_password
    Devise.friendly_token(256)
  end

  def otp_pending?
    !otp_secret.nil? && otp_required_for_login != true
  end

  def generate_reset_token
    @reset_token, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.current.utc
    save(validate: false)

    @reset_token
  end
end
