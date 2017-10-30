class MProject < ApplicationRecord
  validates :project_no, inclusion: { in: %w(small medium large),
                                message: "%{value}は有効な値ではありません" }
  validates :project_no, presence: true
  validates :name, presence: true
end
