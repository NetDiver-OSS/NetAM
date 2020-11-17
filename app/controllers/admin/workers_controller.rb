# frozen_string_literal: true

module Admin
  class WorkersController < ApplicationController
    load_and_authorize_resource
    before_action :set_sections, only: [:create, :update, :new, :edit]

    # GET /workers
    def index
      @workers = Worker.all
    end

    # GET /workers/new
    def new
      @worker = Worker.new
    end

    # GET /workers/1/edit
    def edit
      # not used actually
    end

    # POST /workers
    def create
      @worker = Worker.new(worker_params)

      section_selected = params.dig(:worker, :sections) || []
      @worker.sections = section_selected.reject(&:empty?).map { |section| Section.find(section.to_i) }

      if @worker.save
        redirect_to admin_workers_path, notice: _('Worker was successfully created.')
      else
        render :new
      end
    end

    # PATCH/PUT /workers/1
    def update
      if @worker.update(worker_params)
        section_selected = params.dig(:worker, :sections) || []
        @worker.sections = section_selected.reject(&:empty?).map { |section| Section.find(section.to_i) }

        redirect_to admin_workers_path, notice: _('Worker was successfully updated.')
      else
        render :edit
      end
    end

    # DELETE /workers/1
    def destroy
      @worker.destroy
      redirect_to admin_workers_path, notice: _('Worker was successfully destroyed.')
    end

    private

    def set_sections
      @sections = Section.all.pluck(:name, :id)
    end

    def worker_params
      params.require(:worker).permit(:name, :sections)
    end
  end
end
