require 'csv'

class CsvFileReader

  # covert csv row to active record model list using mapping hash
  # param
  #   mapping : ex:{1 => "hoge", 2 => "foo"} 各行の列2の値をmodel.hogeに、列3の値をmodel.fooに設定する
  def self.convertCsvToObject(csv_file_path, model, mapping, start_row)
    model_list = []
    CSV.foreach(csv_file_path).with_index(1) do |row, index|
      if((index +1) > start_row)
        # 読み込み開始行以降処理
        buff_model = model.dup
        mapping.each do | col_num, property |
          # mapping情報から、csvの列位置とモデルのプロパティを紐付けて、プロパティを設定
          buff_model.attributes = {property => row[col_num]}
        end
        model_list.push(buff_model);
      end
    end
    return model_list
  end
end
