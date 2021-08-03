# frozen_string_literal: true

FastGettext.add_text_domain 'netdiver', path: 'locale', type: :po
FastGettext.default_available_locales = NetDiver::Translation::AVAILABLE_LOCALE.keys
FastGettext.default_text_domain = 'netdiver'
FastGettext.default_locale = NetDiver::Translation::DEFAULT_LOCALE
