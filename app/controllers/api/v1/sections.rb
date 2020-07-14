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

        desc 'Return a section'
        params do
          requires :id, type: String, desc: 'ID of the section'
        end
        get ':id', root: 'section' do
          Section.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
