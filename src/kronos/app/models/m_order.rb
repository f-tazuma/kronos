class MOrder < ApplicationRecord
  attr_accessor :no, :name, :description, :m_projects_id, :client_name, :sales_kind,
                :estimate_worker_hours, :order_worker_hours, :order_volume, :receiving_inspection_date,
                :status, :created_at, :updated_at
end
