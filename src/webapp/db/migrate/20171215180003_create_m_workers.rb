class CreateMWorkers < ActiveRecord::Migration[5.1]
  def change
    create_table :m_workers ,comment:'作業者マスタ'do |t|
      t.string :worker_number, null: false, limit: 20
      t.string :family_name, null: true, limit: 50
      t.string :first_name, null: true, limit: 50
      t.string :full_name, null: true, limit: 100
      t.string :family_name_kana, null: true, limit: 50
      t.string :first_name_kana, null: true, limit: 50
      t.string :mail_address, null: true, limit: 200
      t.datetime :birth_day, null: true
      t.bigint :m_department_id, foreign_key: true
      t.timestamps
    end
    add_index :m_workers, :worker_number, :unique => true
    # add_foreign_key :m_workers, :m_departments, column: :m_department_id
  end
end
