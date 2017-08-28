class ImportCsvsService

  def initialize(file_path)
    @file_path = file_path
  end

  # 社員マスター取り込み処理
  def import_workers

    map = {
        0 => 'worker_number',
        1 => 'family_name',
        2 => 'first_name',
        3 => 'family_name_kana',
        4 => 'first_name_kana',
        30 => 'mail_address',
        17 => 'm_department_id'
    }
    workers = CsvFileReader::convert_csv_to_object(@file_path, MWorker.new(), map, 2)

    workers.each do |worker|
      worker.save
    end

  end
end