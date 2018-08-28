class SalesDao
  # プロジェクトに紐づく受注情報を取得する
  def self.select_orders_by_project_id(project_id)
    sql ='
      SELECT
        orders.order_no,
        orders.name,
        orders.estimate_work_hours,
        orders.ordered_work_hours,
        orders.ordered_volume
      FROM m_projects projects
      INNER JOIN m_orders orders
        ON projects.id = orders.m_project_id
      WHERE projects.id = ?
      ORDER BY orders.order_no'

    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql, project_id]
    )
    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result
  end

  # 対象プロジェクトの月次売り上げを取得する
  def self.select_monthly_sales_by_project_id(project_id)
    sql = '
      SELECT
        year(work_day) year,
        month(work_day) month,
        SUM(work_hours) total
      FROM t_worked_hours
        INNER JOIN m_orders
          ON t_worked_hours.order_no = m_orders.order_no
        INNER JOIN m_projects
          ON m_orders.m_project_id = m_projects.id
             AND m_projects.id = ?
      GROUP BY year, month
    '
    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql, project_id]
    )
    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result

  end

end