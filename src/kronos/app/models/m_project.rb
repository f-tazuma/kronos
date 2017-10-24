class MProject < ApplicationRecord
  validates :project_no, presence: true
  validates :name, presence: true;
end
