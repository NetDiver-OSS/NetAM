module API
  module V1
    class Sections < Grape::API
      include API::V1::Defaults

      before do
        authenticate!
      end

      resource :sections do
        desc 'Return all sections'
        get '', root: 'section' do
          Section.all
        end

        desc 'Create a section'
        params do
          requires :name, type: String
          requires :network, type: String
          requires :schedule, type: String
          optional :description, type: String
        end
        post '', root: 'section' do
          Section.create!(declared_params(include_missing: false))
        end

        desc 'Return a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        get ':id', root: 'section' do
          Section.where(id: permitted_params[:id]).first!
        end

        desc 'Return usage for a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        get ':id/usages', root: 'section' do
          Section.where(id: permitted_params[:id]).first!.usages
        end
      end
    end
  end
end
