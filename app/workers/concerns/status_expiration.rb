# frozen_string_literal: true

module StatusExpiration
  extend ActiveSupport::Concern

  def expiration
    @expiration ||= 60 * 60 * 24 * 30
  end
end
