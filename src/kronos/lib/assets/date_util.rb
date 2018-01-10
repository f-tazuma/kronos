require "date"

class DateUtil
  # 年(数値)、週番号(数値)を引数に、対象週番号に該当する日を配列で返す
  def self.get_days_by_week_num(year, week_number)
    year_start_date = Date.new(year, 1, 1)
    # 対象週番号から1/1に加算する日付を生成
    plus_days = 7 * week_number

    # 基準日を作成 ※ 1/1が日曜日想定での計算のため、必ずしも週番号と一致はしない
    base_date = year_start_date + plus_days

    days = []

    # 基準日を1日ずつ減らしていき、パラメータ週番号と同じ日を配列に追加する
    while base_date.cweek >= week_number do
      if(base_date.cweek == week_number)
        days.push(base_date)
      end
      # 基準日を1日減らす
      base_date = base_date - 1

      if(year != base_date.year)
        break
      end
    end

    return days
  end
end