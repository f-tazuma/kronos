require_relative '../../test_helper'
require_relative '../../../lib/assets/csv_file_reader'

class CsvFileReaderTest < ActiveSupport::TestCase

  def setup
  end

  test 'Csv File should convert model' do
    file_path = File.expand_path('./../../../_data/source_csvs/Anken.csv', __FILE__)
    map = {0 => 'no', 2 => 'name', 15 => 'client_name', 32 => 'receiving_inspection_date', 34 => 'order_volume', }
    CsvFileReader::convertCsvToObject(file_path, MOrder.new(), map, 2)
  end
end

