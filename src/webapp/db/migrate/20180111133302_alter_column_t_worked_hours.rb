class AlterColumnTWorkedHours < ActiveRecord::Migration[5.1]
  def change
    # カラム変更: change_column(テーブル名, カラム名, データタイプ, オプション)
    change_column :t_worked_hours, :work_day, :date

    # カラム追加: add_column(テーブル名, カラム名, データタイプ, オプション)
    add_column :t_worked_hours, :work_content, :string, :after => :work_day
    add_column :t_worked_hours, :sales_entry_name, :string, :after => :work_day

  end
end
