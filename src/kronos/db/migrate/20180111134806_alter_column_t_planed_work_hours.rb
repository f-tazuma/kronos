class AlterColumnTPlanedWorkHours < ActiveRecord::Migration[5.1]
  def change
    # [形式] change_column(テーブル名, カラム名, データタイプ, オプション)
    change_column :t_planed_work_hours, :work_plan_day, :date
  end
end
