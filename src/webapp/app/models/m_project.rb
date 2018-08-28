class MProject < ApplicationRecord
  # バリデーション
  validates :project_no,
            presence: { message: "%{value}は必須"},
            format: { with: /\A[0-9A-Za-z]+\z/, message: "%{value}は英数字のみ" },
            length: { in: 5..20, message: "%{value}は5文字以上、20文字以下" },
            uniqueness: {message: "%{value}はすでに登録"}
end
