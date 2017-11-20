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

    # work_hours = Hash.new { |h,k| h[k] = {} }
    # tmp_work_hours.each do | elem |
    #   week_num = elem['week_num_of_year']
    #   workers_id = elem['workers_id']
    #   work_hours[workers_id][week_num] =  elem['week_work_hours']
    # end

    tmp_work_hours = {}
    tmp_week_nums = []

    db_work_hours.each do | elem |
      workers_id = elem['workers_id']
      week_num = elem['week_num_of_year']
      tmp = {}
      tmp[week_num] = elem['week_work_hours']

      if(tmp_work_hours.key?(workers_id))
        tmp_work_hours[workers_id].push(tmp)
      else
        tmp_work_hours[workers_id] = []
        tmp_work_hours[workers_id].push(tmp)
      end

      # 週番号を配列で保持
      tmp_week_nums.push(week_num)
    end

    work_hours = {}
    work_hours[:worker_week_hours] = tmp_work_hours
    tmp_week_nums.uniq!

    work_hours[:start_week] = tmp_week_nums.min
    work_hours[:end_week] = tmp_week_nums.max

    data[:work_hours] = work_hours

    return data
  end

end