class WorkedHoursDao

  def self.selectSumHoursGroupByOrderNoDate(order_no)
    sql =
        'SELECT
        work.order_no,
        work.work_day,
        sum(work.work_hours) as worked_hours
      FROM t_worked_hours work
        INNER JOIN m_orders orders
          on work.order_no = orders.order_no
      WHERE work.order_no = ?
      GROUP BY work.order_no, work.work_day
      ORDER BY work.order_no, work.work_day'

    # プレースホルダーを利用し、sql文を組み当て
    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql, order_no]
    )

    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result
  end

end
