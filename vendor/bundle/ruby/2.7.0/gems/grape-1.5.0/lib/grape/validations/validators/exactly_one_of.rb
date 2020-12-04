# frozen_string_literal: true

require 'grape/validations/validators/multiple_params_base'

module Grape
  module Validations
    class ExactlyOneOfValidator < MultipleParamsBase
      def validate_params!(params)
        keys = keys_in_common(params)
        return if keys.length == 1
        raise Grape::Exceptions::Validation.new(params: all_keys, message: message(:exactly_one)) if keys.length.zero?
        raise Grape::Exceptions::Validation.new(params: keys, message: message(:mutual_exclusion))
      end
    end
  end
end
