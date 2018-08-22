class CreateTProjectMonthlySales < ActiveRecord::Migration[5.1]
  def change
    create_table :t_project_monthly_sales do |t|
      t.bigint :m_project_id, foreign_key: true
      t.date :sales_month, null: false
      t.decimal :proceeds, precision: 15, scale: 2
      t.string :status, null: false, limit: 10
      t.timestamps
    end
  end
end
