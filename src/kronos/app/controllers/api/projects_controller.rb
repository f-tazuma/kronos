module Api
  class ProjectsController < ApplicationController
    protect_from_forgery with: :null_session

    def show
      @title = 'プロジェクト詳細'
      service = WorkHoursService.new(params)
      @view_bug = service.getDataForProjectShow
      render json: @view_bug
    end

    def updatePlanWorkHours
      @view_bug = {}

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
