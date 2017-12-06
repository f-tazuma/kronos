require "date"

class WorkHoursService

  def initialize(params)
    @params = params

    # 対象期間を設定
    @term_from = params['term_from'] || Date.commercial(Date.today.year, 1, 1)
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

    data[:terms] = get_terms()

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
      year_week_num = "#{year}.#{week_num}"

      if(! tmp_hours.key?(workers_id))
        # 新しい作業者idの場合、対象期間分キーを作成
        tmp_hours[workers_id] = {}
        tmp_hours[workers_id]['hours'] = {}
        tmp_hours[workers_id]['family_name'] = elem['family_name']
        tmp_hours[workers_id]['first_name'] = elem['first_name']
        (@term_from..@term_to).each do | looper |
          key  = "#{looper.year}.#{looper.cweek}"
          tmp_hours[workers_id]['hours'][key] = nil
        end
        tmp_hours[workers_id]['hours'][year_week_num] = elem['week_work_hours']
      else
        tmp_hours[workers_id]['hours'][year_week_num] = elem['week_work_hours']
      end
    end

    return tmp_hours
  end

  def get_terms
    terms = {}
    (@term_from..@term_to).each do | looper |
      buff = {}
      buff['year'] = looper.year
      buff['month'] = looper.month
      buff['cweek'] = looper.cweek
      key  = "#{looper.year}.#{looper.cweek}"
      terms[key] = buff
    end
    return terms
  end

end