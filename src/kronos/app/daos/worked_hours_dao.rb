class WorkedHoursDao

  # 対象プロジェクトの週番号・作業者別稼働時間を取得する
  def self.select_report_worked_data(project_id)
    sql = '
      SELECT
        projects.id,
        projects.name,
        workers.id worker_id,
        workers.worker_number,
        workers.family_name,
        workers.first_name,
        YEAR(worked.work_day) year,
        MONTH(worked.work_day) month_of_year,
        WEEK(worked.work_day, 7) week_num_of_year,
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
        worker_id,
        worker_number,
        workers.family_name,
        workers.first_name,
        year,
        month_of_year,
        week_num_of_year
      ORDER BY
        worker_id, week_num_of_year
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
