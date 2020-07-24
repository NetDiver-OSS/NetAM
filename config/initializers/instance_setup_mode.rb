Rails.application.config.setup_mode = begin
                                        User.all.size.zero?
                                      rescue StandardError
                                        false
                                      end
