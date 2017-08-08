require 'csv'

class CsvFileReader

  def self.convertCsvToObject(csv_file_path, model, mapping, start_row)
    CSV.foreach(csv_file_path).with_index(1) do |row, index|
      if((index +1) > start_row)
        # 読み込み開始行以降処理
        model = model.clone()

        mapping.each do | col_num, property |
          # mapping情報から、csvの列位置とモデルのプロパティを紐付けて、プロパティを設定
          model.attributes = {property => row[col_num]}
        end
        model.save
      end
    end
  end
end
