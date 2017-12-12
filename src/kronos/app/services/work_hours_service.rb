require "date"

class WorkHoursService

  def initialize(params)
    @params = params

    # 対象期間を設定
    @term_from = params['term_from'] || Date.commercial(Date.today.year, 1, 1)
    @term_to = params['term_to'] || Date.new(Date.today.year, 12, 31)
  end

  # プロジェクト情報、稼働時間、計画時間を取得する
  def get_data_for_project_show
    data = {}

    # プロジェクト情報
    data[:project] = MProject.where(:id => @params[:id]).first

    # 稼働時間
    db_work_hours = WorkedHoursDao.select_report_worked_data(@params[:id])
    work_hours = convert_row_report_hash(db_work_hours)

    # 稼働予定時間
    db_planed_work_hours = PlanedWorkHoursDao.select_report_planed_work_data(@params[:id])
    planed_work_hours = convert_row_report_hash(db_planed_work_hours)

    data[:work_hours] = work_hours
    data[:planed_work_hours] = planed_work_hours

    data[:terms] = get_terms()

    return data
  end

  # 計画稼働時間を登録する
  def store_planed_work_hours
    plan_data = @params[:project]
    project_id = @params[:id]

    plan_data.each do |worker_number, work_hours|
      # 作業者毎の予定作業時間データをループ処理
      work_hours.each do |year_week_num, hour|
        if hour != nil
          year_week_num = year_week_num.split(".")
          store_planed(project_id, worker_number, year_week_num[0], year_week_num[1], hour)
        end
      end
    end
  end

  private

  # 週番号から対象日に作業時間を按分してデータ登録する
  def store_planed(project_id, worker_number, year, week_num, hour)
    # 対象週番号の日付を取得
    days = DateUtil::get_days_by_week_num(year.to_i, week_num.to_i)

    ActiveRecord::Base.transaction do
      # 対象日のデータを削除
      TPlanedWorkHour.where(work_plan_day: days.last..days.first)
        .where(worker_number: worker_number)
        .where(m_project_id: project_id).delete_all

      # 対象週の日付配列は先頭2要素が、土曜日、日曜日。よって、2要素は削除する
      days = days.slice(0, 5)
      divmod = hour.to_i.divmod(days.size)

      # 4営業日は按分した作業時間を登録する
      days.first(4).each do |day|
        TPlanedWorkHour.create(
            worker_number: worker_number,
            m_project_id: 1,
            work_plan_day: day,
            work_hours: divmod[0]
        )
      end
      # 1営業日は按分時間に余りを足して登録する
      days.last(1).each do |day|
        TPlanedWorkHour.create(
            worker_number: worker_number,
            m_project_id: 1,
            work_plan_day: day,
            work_hours: divmod[0] + divmod[1]
        )
      end
    end
  end

  # 実績、予定時間のデータベースデータをhashに変換する
  def convert_row_report_hash(db_data)
    tmp_hours = {}

    db_data.each do |elem|
      worker_number = elem['worker_number']
      year = elem['year']
      month = elem['month_of_year']
      week_num = elem['week_num_of_year']
      year_week_num = "#{year}.#{week_num}"

      if(! tmp_hours.key?(worker_number))
        # 新しい作業者idの場合、対象期間分キーを作成
        tmp_hours[worker_number] = {}
        tmp_hours[worker_number]['hours'] = {}
        tmp_hours[worker_number]['family_name'] = elem['family_name']
        tmp_hours[worker_number]['first_name'] = elem['first_name']
        (@term_from..@term_to).each do | looper |
          key  = "#{looper.year}.#{looper.cweek}"
          tmp_hours[worker_number]['hours'][key] = nil
        end
        tmp_hours[worker_number]['hours'][year_week_num] = elem['week_work_hours']
      else
        tmp_hours[worker_number]['hours'][year_week_num] = elem['week_work_hours']
      end
    end

    return tmp_hours
  end

  # 対象期間 年.週番号 を取得する
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