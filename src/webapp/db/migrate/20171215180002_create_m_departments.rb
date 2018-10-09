class CreateMDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :m_departments, comment:'組織マスタ' do |t|
      t.string :name, null: false, limit: 100
      t.string :path, null: false, limit: 1000
      t.text :description, null: true
      t.timestamps
    end
    add_index :m_departments, :path, :unique => true
  end
end
