class CreateTSalesHours < ActiveRecord::Migration[5.1]
  def change
    create_table :t_sales_hours do |t|
      t.bigint :m_project_id, foreign_key: true
      t.date :sales_day, null: false
      t.decimal :sales_work_hours, precision: 8, scale: 2, null: true
      t.timestamps
    end
  end
end
