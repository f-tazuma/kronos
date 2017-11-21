class WorkHoursService

  def initialize(params)
    @params = params
  end

  def getDataForProjectShow
    data = {}

    # プロジェクト情報
    data[:project] = MProject.where(:id => @params[:id]).first

    # 稼働時間
    db_work_hours = WorkedHoursDao.selectReportWorkedData(@params[:id])
    work_hours = convert_row_report_hash(db_work_hours)

    # 稼働予定時間
    db_planed_work_hours = WorkedHoursDao.selectReportPlanedWorkData(@params[:id])
    planed_work_hours = convert_row_report_hash(db_planed_work_hours)

    data[:work_hours] = work_hours
    data[:planed_work_hours] = planed_work_hours

    return data
  end

  private
  def convert_row_report_hash(db_data)
    tmp_hours = {}

    db_data.each do | elem |
      workers_id = elem['workers_id']
      week_num = elem['week_num_of_year']

      if(tmp_hours.key?(workers_id))
        tmp_hours[workers_id]['hours'][week_num] = elem['week_work_hours']
      else
        tmp_hours[workers_id] = {}
        tmp_hours[workers_id]['hours'] = {}
        tmp_hours[workers_id]['hours'][week_num] = {}
        tmp_hours[workers_id]['hours'][week_num] = elem['week_work_hours']
        tmp_hours[workers_id]['family_name'] = elem['family_name']
        tmp_hours[workers_id]['first_name'] = elem['first_name']
      end
    end

    return tmp_hours
  end

end