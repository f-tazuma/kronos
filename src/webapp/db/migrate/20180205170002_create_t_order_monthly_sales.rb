class CreateTOrderMonthlySales < ActiveRecord::Migration[5.1]
  def change
    create_table :t_order_monthly_sales, comment:'受注別月次売上' do |t|
      t.bigint :m_project_id, foreign_key: true
      t.date :sales_month, null: false
      t.decimal :proceeds, precision: 15, scale: 2
      t.string :status, null: false, limit: 10
      t.timestamps
    end
  end
end
