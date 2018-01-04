class CreateTWorkedHours < ActiveRecord::Migration[5.1]
  def change
    create_table :t_worked_hours do |t|
      t.string :worker_number, null: false, limit: 20
      t.string :order_no, null: false, limit: 20
      t.datetime :work_day, null: true
      t.decimal :work_hours, precision: 5, scale: 2, null: true
      t.timestamps
    end
    add_index :t_worked_hours, :worker_number
    add_index :t_worked_hours, :order_no
  end
end
