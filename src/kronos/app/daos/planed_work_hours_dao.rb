class PlanedWorkHoursDao

  # 対象プロジェクトの週番号・作業者別稼働予定時間を取得する
  def self.select_report_planed_work_data(project_id)
    sql = '
      SELECT
        projects.id                          project_id,
        projects.name,
        workers.id                           worker_id,
        workers.worker_number,
        workers.family_name,
        workers.first_name,
        YEAR(planed.work_plan_day)            year,
        MONTH(planed.work_plan_day)           month_of_year,
        WEEK(planed.work_plan_day, 7)         week_num_of_year,
        sum(planed.work_hours)                week_work_hours
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
        worker_id,
        worker_number,
        workers.family_name,
        workers.first_name,
        year,
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