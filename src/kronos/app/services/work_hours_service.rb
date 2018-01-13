require "date"

class WorkHoursService

  def initialize(params)
    @params = params
    project_id = @params[:id]

    # 実績工数
    @db_work_hours = WorkedHoursDao.select_report_worked_data(project_id)
    # 予定工数
    @db_planed_work_hours = PlanedWorkHoursDao.select_report_planed_work_data(project_id)

    @hours = {}
    set_term()
  end

  # プロジェクト情報、稼働時間、計画時間を取得する
  def get_data_for_project_show
    data = {}

    project_id = @params[:id]

    # プロジェクト情報
    data[:project] = MProject.where(:id => project_id).first
    # 受注情報
    @orders = OrdersDao.select_orders_by_project_id(project_id)
    data[:orders] = @orders

    # 集計情報
    data[:total] = get_total_work_hours(project_id)

    # 稼働情報
    # 稼働時間
    convert_row_report_hash(@db_work_hours, "work")
    # 稼働予定時間
    convert_row_report_hash(@db_planed_work_hours, "plan")

    data[:hours] = @hours
    data[:weeks] = get_weeks()
    data[:weeks_of_year_month] = get_weeks_of_year_month(data[:weeks])

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

  # 表示期間対象週を設定する
  def set_term
    # 開始：実績工数ベースの最初の週（実績がない場合は、システム日時の週）
    if @db_work_hours.length > 0
      sorted = @db_work_hours.sort_by{ |item| item['start_work_day'] }
      @term_from = sorted.first['start_work_day'].to_date
      @term_to = sorted.last['start_work_day'].to_date
    else
      @term_from = Date.today
    end

    # 実績工数、予定工数の最後の週+3ヶ月（実績、予定がない場合は、システム日時+3ヶ月）
    if @db_planed_work_hours.length > 0
      plan_sorted = @db_planed_work_hours.sort_by{ |item| item['start_work_day'] }
      @term_to = plan_sorted.last['start_work_day'].to_date
    end

    if !@term_to
      @term_to = Date.today()
    end

    @term_to = @term_to + 3.months

  end

  # 作業時間の集計値情報を取得する
  def get_total_work_hours(project_id)
    data = {}
    consume_worked_hours = OrdersDao.select_total_consume_worked_hours(project_id, Date.today())
    planed_work_hours = PlanedWorkHoursDao.select_total_planed_work_hours(project_id, Date.today())

    # 作業実績、作業予定工数は「受注,年,月」毎の集計値なので、トータルを求める
    sum_consume = get_total_from_hours(consume_worked_hours)
    sum_plan = get_total_from_hours(planed_work_hours)

    # 受注情報から受注工数、受注金額を合計する
    total_estimate_work_hours = 0
    total_ordered_work_hours = 0
    @orders.each do |order|
      if order['estimate_work_hours'] != nil
        total_estimate_work_hours = total_estimate_work_hours + order['estimate_work_hours']
      end
      if order['ordered_work_hours'] != nil
        total_ordered_work_hours = total_ordered_work_hours + order['ordered_work_hours']
      end
    end

    data[:consume_worked_hours] = consume_worked_hours
    data[:planed_work_hours] = planed_work_hours
    data[:total_estimate_work_hours] = total_estimate_work_hours
    data[:total_ordered_work_hours] = total_ordered_work_hours

    # 作業済工数
    data[:total_consume_worked_hours] = get_total_from_hours(consume_worked_hours)
    # 計画工数
    data[:total_planed_work_hours] = get_total_from_hours(planed_work_hours)

    # 着地見込み工数
    data[:landing_total_work_hours] = data[:total_consume_worked_hours] + data[:total_planed_work_hours]

    # 現時点残工数
    data[:current_rest_work_hours] = total_ordered_work_hours - (data[:total_consume_worked_hours])
    # 着地時点残工数
    data[:landing_rest_work_hours] = total_ordered_work_hours - (data[:landing_total_work_hours])

    # 工数進捗率
    if total_ordered_work_hours == 0
      data[:current_rate_of_work_hour_progress] = 0
    else
      rate = data[:total_consume_worked_hours] / total_ordered_work_hours * 100
      data[:current_rate_of_work_hour_progress] = rate.round(2);
    end

    return data
  end

  # 「受注,年,月」毎の集計値データを集計する
  def get_total_from_hours(hours_data)
    total = 0
    hours_data.each do |elem|
      if elem['worked_hours'] != nil
        total = total + elem['worked_hours']
      end
    end
    return total
  end

  # 週番号から対象日に作業時間を按分してデータ登録する
  def store_planed(project_id, worker_number, year, week_num, hour)
    if hour == 0
      return
    end

    # 対象週番号の日付を取得
    days = DateUtil::get_workdays_by_week_num(year.to_i, week_num.to_i)

    ActiveRecord::Base.transaction do
      # 対象日のデータを削除
      TPlanedWorkHour.where(work_plan_day: days.first.to_time..days.last.to_time)
        .where(worker_number: worker_number)
        .where(m_project_id: project_id).delete_all

      # 作業時間を按分
      divmod = hour.to_i.divmod(days.size)
      p = divmod[0] # 商
      q = divmod[1] # 余り

      days_work_hours = []
      # 対象日に商を設定
      days.each do | day |
        days_work_hours.push(p)
      end

      # 余りの数分ループ処理して、1加算する
      0.upto(q-1) { |i|
        days_work_hours[i] += 1
      }

      # DBデータ登録
      days.each_with_index do |day, index|
        TPlanedWorkHour.create(
            worker_number: worker_number,
            m_project_id: project_id,
            work_plan_day: day,
            work_hours: days_work_hours[index]
        )
      end
    end
  end

  # 実績、予定時間のデータベースデータをhashに変換する
  def convert_row_report_hash(db_data, hour_type)
    db_data.each do |elem|
      worker_number = elem['worker_number']
      year = elem['year']
      month = elem['month_of_year']
      week_num = elem['week_num_of_year']
      year_week_num = "#{year}.#{week_num}"

      if !@hours.key?(worker_number)
        # 新しい作業者idの場合、対象期間分キーを作成
        @hours[worker_number] = {}
        @hours[worker_number]['work'] = {}
        @hours[worker_number]['plan'] = {}
        @hours[worker_number]['family_name'] = elem['family_name']
        @hours[worker_number]['first_name'] = elem['first_name']

        (@term_from..@term_to).each do | looper |
          key  = "#{looper.year}.#{looper.cweek}"
          @hours[worker_number]['work'][key] = nil
          @hours[worker_number]['plan'][key] = nil
        end
        @hours[worker_number][hour_type][year_week_num] = elem['week_work_hours']
      else
        @hours[worker_number][hour_type][year_week_num] = elem['week_work_hours']
      end
    end
  end

  # 対象期間 年.週番号 を取得する
  def get_weeks
    weeks = {}
    (@term_from..@term_to).each do | looper |
      buff = {}
      buff['year'] = looper.year
      buff['month'] = looper.month
      buff['cweek'] = looper.cweek
      key  = "#{looper.year}.#{looper.cweek}"
      weeks[key] = buff
    end
    return weeks
  end

  # 週番号の年、月単位の数を取得する
  def get_weeks_of_year_month(terms)
    # 週番号について、年、月毎に数を求める
    weeks_of_year_month = {}
    tmp_year, tmp_month = nil
    terms.each do | key, looper |
      if tmp_year != looper['year']
        tmp_year = looper['year']
        weeks_of_year_month[tmp_year] = {}
        weeks_of_year_month[tmp_year]['total'] = 1
      else
        weeks_of_year_month[tmp_year]['total'] += 1
      end

      if tmp_month != looper['month']
        tmp_month = looper['month']
        weeks_of_year_month[tmp_year][tmp_month] = 1
      else
        weeks_of_year_month[tmp_year][tmp_month] += 1
      end
    end

    return weeks_of_year_month
  end

end