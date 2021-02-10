# frozen_string_literal: true

require 'doorkeeper/grape/helpers'

module API
  module V1
    class Sections < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      REQUIRES_ID = 'ID of the section'

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
          requires :vlan_id, type: Integer
          optional :description, type: String
        end
        post '', root: 'section' do
          ::Sections::CreateService.new(current_user, declared_params(include_missing: false)).execute
        end

        desc 'Return a section'
        params do
          requires :id, type: String, desc: REQUIRES_ID
        end
        get ':id', root: 'section' do
          section = Section.where(id: permitted_params[:id]).first!
          authorize! :read, section
          section
        end

        desc 'Launch scan for a section'
        params do
          requires :id, type: String, desc: REQUIRES_ID
        end
        post ':id/scan', root: 'section' do
          @section = Section.find(permitted_params[:id])
          authorize! :scan, @section
          ScanNetworkWorker.perform_async({ id: @section, network: @section.network, scan_type: @section.scan_type })

          { status: 'ack' }
        end

        desc 'Return usage for a section'
        params do
          requires :id, type: String, desc: REQUIRES_ID
        end
        get ':id/usages', root: 'section' do
          section = Section.find(permitted_params[:id]).usages
          authorize! :read, section
          section
        end

        desc 'Create a usage for a section'
        params do
          requires :id, type: String, desc: REQUIRES_ID
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

        desc 'Request free IP in section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        post ':id/request_ip', root: 'section' do
          section = Section.find(permitted_params[:id])
          authorize! :read, section

          requested_ip = section.unused_ip
          if requested_ip.nil?
            status 422
            { error: _('No free address IP available !') }
          else
            section.usages.create!(ip_used: requested_ip)
          end
        end

        desc 'Export section to CSV'
        params do
          requires :id, type: String, desc: REQUIRES_ID
        end
        get ':id/export', root: 'section' do
          content_type 'text/csv'
          env['api.format'] = :binary
          section = Section.find(permitted_params[:id])
          ExportSectionToCsvJob.perform_now(section)
        end
      end
    end
  end
end
