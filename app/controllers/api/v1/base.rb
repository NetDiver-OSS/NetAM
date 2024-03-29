# frozen_string_literal: true

module API
  module V1
    class Base < Grape::API
      mount API::V1::Search

      mount API::V1::Sections
      mount API::V1::Vlans
      mount API::V1::Backups
      mount API::V1::Devices
      mount API::V1::DeviceTypes
      mount API::V1::Rackspaces

      add_swagger_documentation(
        api_version: 'v1',
        hide_documentation_path: true,
        mount_path: '/v1/swagger_doc',
        hide_format: true
      )
    end
  end
end
