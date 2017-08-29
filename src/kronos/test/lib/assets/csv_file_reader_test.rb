require_relative '../../test_helper'
require_relative '../../../lib/assets/csv_file_reader'

class CsvFileReaderTest < ActiveSupport::TestCase

  def setup
  end

  test 'Csv File should convert model' do
    file_path = File.expand_path('./../../../_data/source_csvs/Anken.csv', __FILE__)
    map = {0 => 'no', 2 => 'name', 15 => 'client_name', 32 => 'receiving_inspection_date', 34 => 'order_volume', }
    ankens = CsvFileReader::convert_csv_to_hash_list(file_path,map,2)

    # 2行目以降modelに変換するため取得できるmodelは84個
    assert_equal 84, ankens.size

    # 1列目がnoにマッピングされる
    assert_equal "1200173", ankens[0]["no"]

    # 3列目がnameにマッピングされる
    assert_equal "湯沢市乗合タクシー予約 操作性改善", ankens[1]["name"]

    # 16列目がclient_nameにマッピングされる
    assert_equal "日本放送協会 ", ankens[2]["client_name"]

    # 35列目がorder_volumeにマッピングされる
    assert_equal "1400000", ankens[4]["order_volume"]
  end
end

