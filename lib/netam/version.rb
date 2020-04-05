module Netam
  class Version
    @netam_version_file = 'NETAM_VERSION'

    def self.current
      @version ||= File.read(@netam_version_file).chomp if File.readable?(@netam_version_file)
    end
  end
end
