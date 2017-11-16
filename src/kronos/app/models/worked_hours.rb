class WorkedHours

  def selectSumHoursGroupByOrderNoDate(order_no)
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

    con = ActiveRecord::Base.connection
    result = con.select_all(sql, [order_no])
    result.to_hash
    return result
  end
end