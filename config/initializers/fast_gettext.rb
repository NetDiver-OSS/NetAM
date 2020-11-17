# frozen_string_literal: true

FastGettext.add_text_domain 'netam', path: 'locale', type: :po
FastGettext.default_available_locales = NetAM::Translation::AVAILABLE_LOCALE.keys
FastGettext.default_text_domain = 'netam'
FastGettext.default_locale = NetAM::Translation::DEFAULT_LOCALE
