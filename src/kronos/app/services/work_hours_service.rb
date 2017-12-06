require "date"

class WorkHoursService

  def initialize(params)
    @params = params

    # 対象期間を設定
    @term_from = params['term_from'] || Date.new(Date.today.year, 1, 1)
    @term_to = params['term_to'] || Date.new(Date.today.year, 12, 31)
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

    db_data.each do |elem|
      workers_id = elem['workers_id']
      year = elem['year']
      month = elem['month_of_year']
      week_num = elem['week_num_of_year']
      year_month_week_num = "#{year}/#{month}/#{week_num}"

      if(tmp_hours.key?(workers_id))
        (@term_from..@term_to).each do | looper |
          year_month_week_num  = "#{looper.year}/#{looper.month}/#{looper.cweek}"
          p year_month_week_num
        end

        tmp_hours[workers_id]['hours'][year_month_week_num] = elem['week_work_hours']
      else
        tmp_hours[workers_id] = {}
        tmp_hours[workers_id]['hours'] = {}
        tmp_hours[workers_id]['hours'][year_month_week_num] = {}
        tmp_hours[workers_id]['hours'][year_month_week_num] = elem['week_work_hours']
        tmp_hours[workers_id]['family_name'] = elem['family_name']
        tmp_hours[workers_id]['first_name'] = elem['first_name']


      end

    (@term_from..@term_to).each do | looper |
      year_month_week_num  = "#{looper.year}/#{looper.month}/#{looper.cweek}"
      p year_month_week_num
    end

    db_data.each do | elem |
      workers_id = elem['workers_id']
      year = elem['year']
      month = elem['month_of_year']
      week_num = elem['week_num_of_year']
      year_month_week_num = "#{year}/#{month}/#{week_num}"

      if(tmp_hours.key?(workers_id))
        tmp_hours[workers_id]['hours'][year_month_week_num] = elem['week_work_hours']
      else
        tmp_hours[workers_id] = {}
        tmp_hours[workers_id]['hours'] = {}
        tmp_hours[workers_id]['hours'][year_month_week_num] = {}
        tmp_hours[workers_id]['hours'][year_month_week_num] = elem['week_work_hours']
        tmp_hours[workers_id]['family_name'] = elem['family_name']
        tmp_hours[workers_id]['first_name'] = elem['first_name']
      end
    end

    return tmp_hours
  end

end