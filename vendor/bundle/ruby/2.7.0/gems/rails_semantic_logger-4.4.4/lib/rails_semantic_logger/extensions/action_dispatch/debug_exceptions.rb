# Log actual exceptions, not a string representation
ActionDispatch::DebugExceptions
module ActionDispatch
  class DebugExceptions
    private

    def log_error(_request, wrapper)
      ActiveSupport::Deprecation.silence do
        ActionController::Base.logger.fatal(wrapper.exception)
      end
    end
  end
end
