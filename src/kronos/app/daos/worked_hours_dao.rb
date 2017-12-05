class WorkedHoursDao

  # 対象プロジェクトの週番号・作業者別稼働時間を取得する
  def self.selectReportWorkedData(project_id)
    sql = '
      SELECT
        projects.id,
        projects.name,
        workers.id workers_id,
        workers.family_name,
        workers.first_name,
        EXTRACT(YEAR FROM worked.work_day) year,
        EXTRACT(MONTH FROM worked.work_day) month_of_year,
        EXTRACT(WEEK FROM worked.work_day)  week_num_of_year,
        sum(worked.work_hours) week_work_hours
        FROM t_worked_hours worked
      INNER JOIN m_orders orders
        ON worked.order_no = orders.order_no
      INNER JOIN m_projects projects
        ON orders.m_project_id = projects.id
      INNER JOIN m_workers workers
        ON worked.worker_number = workers.worker_number
      WHERE
      projects.id = ?
      GROUP BY
        projects.id,
        projects.name,
        workers_id,
        workers.family_name,
        workers.first_name,
        year,
        month_of_year,
        week_num_of_year
      ORDER BY
      workers_id, week_num_of_year
    '
    # プレースホルダーを利用し、sql文を組み当て
    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql, project_id]
    )
    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result
  end

  # 対象プロジェクトの週番号・作業者別稼働予定時間を取得する
  def self.selectReportPlanedWorkData(project_id)
    sql = '
      SELECT
        projects.id                          project_id,
        projects.name,
        workers.id                           workers_id,
        workers.family_name,
        workers.first_name,
        EXTRACT(MONTH FROM planed.work_plan_day) month_of_year,
        EXTRACT(WEEK FROM planed.work_plan_day) week_num_of_year,
        sum(planed.work_hours)                   week_plan_hours
      FROM t_planed_work_hours planed
        INNER JOIN m_projects projects
          ON planed.m_project_id = projects.id
        INNER JOIN m_workers workers
          ON planed.worker_number = workers.worker_number
      WHERE
        projects.id = ?
      GROUP BY
        projects.id,
        projects.name,
        workers_id,
        workers.family_name,
        workers.first_name,
        month_of_year,
        week_num_of_year
    '
    # プレースホルダーを利用し、sql文を組み当て
    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql, project_id]
    )
    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result
  end

end
