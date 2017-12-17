class WorkersDao
  # 検索条件に応じた作業者を検索する
  def self.select_workers_by_conditions(conditions)
    sql ='
      SELECT
        department.name department_name,
        worker.family_name,
        worker.first_name,
        worker.family_name_kana,
        worker.first_name_kana
      FROM m_workers worker
      INNER JOIN m_departments department
        ON worker.m_department_id = department.id
    '

    prepared = ActiveRecord::Base.send(
        :sanitize_sql_array, [sql]
    )
    con = ActiveRecord::Base.connection
    result = con.select_all(prepared)
    result.to_hash
    return result
  end
end