class WorkHoursService

  def initialize(params)
    @params = params
  end

  def getDataForProjectShow
    @project = MProject.where(:id => @params[:id]).first
    @work_hours = WorkedHoursDao.selectSumHoursGroupByOrderNoDate(@params[:id])
  end
end