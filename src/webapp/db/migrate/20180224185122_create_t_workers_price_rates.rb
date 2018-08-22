class CreateTWorkerPriceRates < ActiveRecord::Migration[5.1]
  def change
    create_table :t_worker_price_rates do |t|
      t.bigint :m_worker_id, foreign_key: true
      t.bigint :m_price_rate_id, foreign_key: true
      t.timestamps
    end
  end
end
