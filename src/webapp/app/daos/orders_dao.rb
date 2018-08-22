class OrdersDao
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

  # 対象プロジェクトに紐づく受注情報の、指定日までの消化工数を取得する
  def self.select_total_consume_worked_hours(project_id, day)
    sql = '
      SELECT
        orders.order_no,
        orders.name,
        YEAR(worked.work_day) year,
        MONTH(worked.work_day) month,
        sum(worked.work_hours) worked_hours
      FROM m_projects projects
      INNER JOIN m_orders orders
        ON projects.id = orders.m_project_id
        AND projects.id = ?
      INNER JOIN t_worked_hours worked
        ON orders.order_no = worked.order_no
      WHERE worked.work_day <= ?
      GROUP BY
        order_no, name, year, month
      ORDER BY orders.order_no, year, month'

    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql, project_id, day]
    )
    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result
  end
end