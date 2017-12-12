module Api
  class ProjectsController < ApplicationController
    protect_from_forgery with: :null_session

    def show
      service = WorkHoursService.new(params)
      @view_bug = service.get_data_for_project_show
      render json: @view_bug
    end

    def update_plan_work_hours
      @view_bug = {}
      service = WorkHoursService.new(params)
      service.update_plan_work_hours
      render json: @view_bug
    end

    private

    def project_params
      params.require(:m_project).permit(
        :project_no,
        :name,
        :description,
        :work_start_date,
        :work_end_date
      )
    end
  end
end
