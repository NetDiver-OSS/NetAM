module API
  module V1
    class Base < Grape::API
      mount API::V1::Sections

      add_swagger_documentation(
        api_version: "requests.api.v1",
        hide_documentation_path: true,
        mount_path: "/requests.api/requests.api.v1/swagger_doc",
        hide_format: true
      )
    end
  end
end
