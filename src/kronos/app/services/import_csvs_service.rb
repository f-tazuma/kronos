class ImportCsvsService

  def initialize(file_path)
    @file_path = file_path
  end

  # 社員情報取り込み処理
  def import_workers

    map = {
        0 => 'worker_number',
        1 => 'family_name',
        2 => 'first_name',
        3 => 'family_name_kana',
        4 => 'first_name_kana',
        30 => 'mail_address',
        17 => 'm_department_id',
    }
    workers_hash_list = CsvFileReader::convert_csv_to_hash_list(@file_path, map, 2, true)

    workers_hash_list.each do |worker_hash|
      # worker_numberで社員を検索
      worker = MWorker.where(worker_number: worker_hash['worker_number']).take
      if(worker)
        # 存在する場合アップデート
        worker.update(worker_hash)
      else
        MWorker.create(worker_hash)
      end
    end
  end

  # 案件情報取り込み処理
  def import_orders

    map = {
        0 => 'order_no',
        2 => 'name',
        15 => 'client_name',
        24 => 'ordered_date',
        26 => 'receiving_inspection_date',
        34 => 'ordered_volume'
    }
    orders_hash_list = CsvFileReader::convert_csv_to_hash_list(@file_path, map, 2, true)

    orders_hash_list.each do |order_hash|
      # noで受注を検索
      order = MOrder.where(order_no: order_hash['order_no']).take
      if(order)
        # 存在する場合アップデート
        order.update(order_hash)
      else
        MOrder.create(order_hash)
      end
    end
  end

  # 稼働情報取り込み処理
  def import_work_hours(target_year_month)

    map = {
        1 => 'order_no',
        9 => 'worker_number',
        11 => 'work_day',
        16 => 'work_hours'
    }
    work_hours_hash_list = CsvFileReader::convert_csv_to_hash_list(@file_path, map, 2, true)

    ActiveRecord::Base.transaction do
      # データ取り込み対象月を削除
      sql = ActiveRecord::Base.send(
          :sanitize_sql_array,
          ["DELETE FROM t_worked_hours WHERE DATE_FORMAT(work_day, '%Y%m') = ?", target_year_month]
      )
      $result = ActiveRecord::Base.connection.execute(sql)

      work_hours_hash_list.each do |work_hour_hash|
        TWorkedHour.create(work_hour_hash)
      end
    end
  end
end