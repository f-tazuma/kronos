class CreateMOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :m_orders, comment:'受注マスタ' do |t|
      t.string :order_no, null: false, limit: 20
      t.string :name, null: false, limit: 100
      t.string :client_name, null: false, limit: 100
      t.text :description, null: true
      t.datetime :ordered_date, null: true
      t.bigint :m_project_id, foreign_key: true
      t.datetime :receiving_inspection_date, null: true
      t.string :order_kind, null: true, limit: 50
      t.string :sales_kind, null: true, limit: 50
      t.decimal :estimate_work_hours, precision: 8, scale: 2, null: true
      t.decimal :ordered_work_hours, precision: 8, scale: 2, null: true
      t.bigint :ordered_volume, null: true
      t.string :status, null: true, limit: 50
      t.timestamps
    end
    add_index :m_orders, :order_no, :unique => true
    # add_foreign_key :m_orders, :m_projects, column: :m_project_id
  end
end