class CreateTPlanedWorkHours < ActiveRecord::Migration[5.1]
  def change
    create_table :t_planed_work_hours do |t|
      t.string :worker_number, null: false, limit: 20
      t.bigint :m_project_id, foreign_key: true
      t.bigint :t_order_work_breakdown_id, foreign_key: true, null: true
      t.datetime :work_plan_day, null: false
      t.decimal :work_hours, precision: 5, scale: 2, null: true
      t.timestamps
    end
    add_index :t_planed_work_hours, :worker_number
    # add_foreign_key :t_planed_work_hours, :m_projects, column: :m_project_id
    # add_foreign_key :t_planed_work_hours, :t_order_work_breakdowns, column: :t_order_work_breakdown_id
  end
end
