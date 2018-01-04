class CreateMProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :m_projects do |t|
      t.string :project_no, null: false, limit: 20
      t.string :name, null: false, limit: 100
      t.text :description, null: true
      t.datetime :work_start_date, null: true
      t.datetime :work_end_date, null: true
      t.timestamps
    end
    add_index :m_projects, :project_no, :unique => true
  end
end
