# frozen_string_literal: true

module Doorkeeper
  module OAuth
    class CodeResponse < BaseResponse
      include OAuth::Helpers

      attr_reader :pre_auth, :auth, :response_on_fragment

      def initialize(pre_auth, auth, options = {})
        @pre_auth = pre_auth
        @auth = auth
        @response_on_fragment = options[:response_on_fragment]
      end

      def redirectable?
        true
      end

      def issued_token
        auth.token
      end

      def redirect_uri
        if URIChecker.oob_uri?(pre_auth.redirect_uri)
          auth.oob_redirect
        elsif response_on_fragment
          Authorization::URIBuilder.uri_with_fragment(
            pre_auth.redirect_uri,
            access_token: auth.token.plaintext_token,
            token_type: auth.token.token_type,
            expires_in: auth.token.expires_in_seconds,
            state: pre_auth.state,
          )
        else
          Authorization::URIBuilder.uri_with_query(
            pre_auth.redirect_uri,
            code: auth.token.plaintext_token,
            state: pre_auth.state,
          )
        end
      end
    end
  end
end
