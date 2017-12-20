class WorkersService
  def initialize
  end

  # 検索条件に応じて、作業者を検索する
  def search_workers(params)
    workers = WorkersDao.select_workers_by_conditions(params)

    # 作業者idをキーにHashに変換
    hash_workers = {}
    workers.each_with_index {|item, idx|
      hash_workers[item['worker_number']] = item
    }

    return hash_workers
  end

end