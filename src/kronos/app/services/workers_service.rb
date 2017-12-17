class WorkersService
  def initialize
  end

  # 検索条件に応じて、作業者を検索する
  def search_workers(params)
    workers = WorkersDao.select_workers_by_conditions(params)
    return workers
  end

end