class TWorkerPriceRatesSeeder

  attr_accessor :data

  def self.run
    data = [
        {:id => 1, :m_worker_id => 1, :m_price_rate_id => 1},
        {:id => 2, :m_worker_id => 2, :m_price_rate_id => 1},
        {:id => 3, :m_worker_id => 3, :m_price_rate_id => 1},
        {:id => 4, :m_worker_id => 4, :m_price_rate_id => 1},
        {:id => 5, :m_worker_id => 5, :m_price_rate_id => 1},
        {:id => 6, :m_worker_id => 6, :m_price_rate_id => 1},
        {:id => 7, :m_worker_id => 7, :m_price_rate_id => 1},
        {:id => 8, :m_worker_id => 8, :m_price_rate_id => 1},
        {:id => 9, :m_worker_id => 9, :m_price_rate_id => 1},
        {:id => 10, :m_worker_id => 10, :m_price_rate_id => 1},
        {:id => 11, :m_worker_id => 11, :m_price_rate_id => 1},
        {:id => 12, :m_worker_id => 12, :m_price_rate_id => 1},
        {:id => 13, :m_worker_id => 13, :m_price_rate_id => 1},
        {:id => 14, :m_worker_id => 14, :m_price_rate_id => 1},
        {:id => 15, :m_worker_id => 15, :m_price_rate_id => 1},
        {:id => 16, :m_worker_id => 16, :m_price_rate_id => 1},
        {:id => 17, :m_worker_id => 17, :m_price_rate_id => 1},
        {:id => 18, :m_worker_id => 18, :m_price_rate_id => 1},
        {:id => 19, :m_worker_id => 19, :m_price_rate_id => 1},
        {:id => 20, :m_worker_id => 20, :m_price_rate_id => 1},
        {:id => 21, :m_worker_id => 21, :m_price_rate_id => 1},
        {:id => 22, :m_worker_id => 22, :m_price_rate_id => 1},
        {:id => 23, :m_worker_id => 23, :m_price_rate_id => 1},
        {:id => 24, :m_worker_id => 24, :m_price_rate_id => 1},
        {:id => 25, :m_worker_id => 25, :m_price_rate_id => 1},
        {:id => 26, :m_worker_id => 26, :m_price_rate_id => 1},
        {:id => 27, :m_worker_id => 27, :m_price_rate_id => 1},
        {:id => 28, :m_worker_id => 28, :m_price_rate_id => 1},
        {:id => 29, :m_worker_id => 29, :m_price_rate_id => 1},
        {:id => 30, :m_worker_id => 30, :m_price_rate_id => 1},
        {:id => 31, :m_worker_id => 31, :m_price_rate_id => 1},
        {:id => 32, :m_worker_id => 32, :m_price_rate_id => 1},
        {:id => 33, :m_worker_id => 33, :m_price_rate_id => 1},
        {:id => 34, :m_worker_id => 34, :m_price_rate_id => 1},
        {:id => 35, :m_worker_id => 35, :m_price_rate_id => 1},
        {:id => 36, :m_worker_id => 36, :m_price_rate_id => 1},
        {:id => 37, :m_worker_id => 37, :m_price_rate_id => 1},
        {:id => 38, :m_worker_id => 38, :m_price_rate_id => 1},
        {:id => 39, :m_worker_id => 39, :m_price_rate_id => 1},
        {:id => 40, :m_worker_id => 40, :m_price_rate_id => 1},
        {:id => 41, :m_worker_id => 41, :m_price_rate_id => 1},
        {:id => 42, :m_worker_id => 42, :m_price_rate_id => 1},
        {:id => 43, :m_worker_id => 43, :m_price_rate_id => 1},
        {:id => 44, :m_worker_id => 44, :m_price_rate_id => 1},
        {:id => 45, :m_worker_id => 45, :m_price_rate_id => 1},
        {:id => 46, :m_worker_id => 46, :m_price_rate_id => 1},
    ]
    TWorkerPriceRate.delete_all
    TWorkerPriceRate.create(data)
  end
end