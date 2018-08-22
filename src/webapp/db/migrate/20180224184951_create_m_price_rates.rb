class CreateMPriceRates < ActiveRecord::Migration[5.1]
  def change
    create_table :m_price_rates do |t|
      t.string :name, null: false, limit: 100
      t.decimal :cost_price, precision: 15, scale: 2
      t.decimal :selling_price , precision: 15, scale: 2
      t.timestamps
    end
  end
end
