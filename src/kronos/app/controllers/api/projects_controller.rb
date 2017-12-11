module Api
  class ProjectsController < ApplicationController

    def show
      @title = 'プロジェクト詳細'
      service = WorkHoursService.new(params)
      @view_bug = service.getDataForProjectShow
      render json: @view_bug
    end

    def updateWorkHours
      p params

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
