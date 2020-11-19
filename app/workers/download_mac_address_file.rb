# frozen_string_literal: true

class LoadMacAddressFile
  module Download
    response = Faraday.get 'http://standards-oui.ieee.org/oui/oui.txt'
  end

  private

  module Inject

  end
end
