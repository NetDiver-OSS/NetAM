module API
  module V1
    class Base < Grape::API
      mount API::V1::Sections
      mount API::V1::Vlans

      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true
      )
    end
  end
end
