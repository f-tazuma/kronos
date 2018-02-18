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

end