class CreateTWorkedHours < ActiveRecord::Migration[5.1]
  def change
    create_table :t_worked_hours, comment:'実績作業工数' do |t|
      t.string :worker_number, null: false, limit: 20
      t.string :order_no, null: false, limit: 20
      t.date :work_day, null: true
      t.string :work_content, null: true
      t.string :sales_entry_name, null: true
      t.decimal :work_hours, precision: 5, scale: 2, null: true
      t.timestamps
    end
    add_index :t_worked_hours, :worker_number
    add_index :t_worked_hours, :order_no
  end
end
