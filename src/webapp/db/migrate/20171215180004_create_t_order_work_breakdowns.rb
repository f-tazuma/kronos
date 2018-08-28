class CreateTOrderWorkBreakdowns < ActiveRecord::Migration[5.1]
  def change
    create_table :t_order_work_breakdowns do |t|
      t.bigint :m_order_id, foreign_key: true
      t.string :work_name, null:false, limit: 20
      t.decimal :estimate_work_hours, precision: 8, scale: 2, null: true
      t.timestamps
    end
    # add_foreign_key :t_order_work_breakdowns, :m_orders, column: :m_order_id
  end
end
