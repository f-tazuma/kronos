require 'csv'

class CsvFileReader

  # covert csv row to active record model list using mapping hash
  # param
  #   mapping : ex:{1 => "hoge", 2 => "foo"} 各行の列2の値をmodel.hogeに、列3の値をmodel.fooに設定する
  def self.convert_csv_to_hash_list(csv_file_path, mapping, start_row, strip_flg=false)
    list = []
    CSV.foreach(csv_file_path).with_index(1) do |row, index|
      if((index +1) > start_row)
        # 読み込み開始行以降処理
        hash = {}
        mapping.each do | col_num, property |
          # mapping情報から、csvの列位置とモデルのプロパティを紐付けて、プロパティを設定
          if(strip_flg and row[col_num].kind_of?(String))
            # strip_flgが有効で、文字列データの場合stripをしたものを設定
            hash[property] = row[col_num].strip
          else
            hash[property] = row[col_num]
          end
        end
        list.push(hash);
      end
    end
    return list
  end
end
