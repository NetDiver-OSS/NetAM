# frozen_string_literal: true

Rails.application.config.setup_mode = User.all.size.zero? rescue false
