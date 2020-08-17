require 'doorkeeper/grape/helpers'

module API
  module V1
    class Sections < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
        authorize_route!
      end

      resource :sections do
        desc 'Return all sections'
        get '', root: 'section', each_serializer: SectionSerializer do
          Section.all.filter { |s| can?(:read, s) }
        end

        desc 'Create a section'
        params do
          requires :name, type: String
          requires :network, type: String
          requires :schedule, type: String
          optional :description, type: String
        end
        post '', root: 'section' do
          section = Section.create!(declared_params(include_missing: false))
          Permission.create!(
            {
              user_id: current_user.id,
              subject_class: 'Section',
              subject_id: section.id,
              action: 'manage'
            }
          )
          section
        end

        desc 'Return a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        get ':id', root: 'section' do
          section = Section.where(id: permitted_params[:id]).first!
          authorize! :read, section
          section
        end

        desc 'Launch scan for a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        post ':id/scan', root: 'section' do
          @section = Section.find(permitted_params[:id])
          authorize! :scan, @section
          ScanNetworkWithPingJob.perform_later({ id: @section, network: @section.network })

          { status: 'ack' }
        end

        desc 'Return usage for a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        get ':id/usages', root: 'section' do
          section = Section.find(permitted_params[:id]).usages
          authorize! :read, section
          section
        end

        desc 'Create a usage for a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
          requires :ip_used, type: String
          requires :fqdn, type: String
          requires :state, type: String
          optional :description, type: String
        end
        post ':id/usages', root: 'section' do
          section = Section.find(permitted_params[:id])
          authorize! :read, section
          section.usages.create!(declared_params(include_missing: false).except(:id))
        end

        desc 'Export section to CSV'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        get ':id/export', root: 'section' do
          section = Section.find(permitted_params[:id])
          csv_export = ExportSectionToCsvJob.perform_now(@section)
          send_data csv_export, filename: "section_usage_#{@section.id}.csv", type: 'text/csv', disposition: 'inline'
        end
      end
    end
  end
end
