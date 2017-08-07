require_relative '../../test_helper'
require_relative '../../../lib/assets/csv_file_reader'

class CsvFileReaderTest < ActiveSupport::TestCase

  def setup
  end

  test 'Csv File should convert model' do
    file_path = File.expand_path('./../../../_data/source_csvs/Anken.csv', __FILE__)
    map = {0 => 'no'}
    CsvFileReader::convertCsvToObject(file_path, MOrder.new(), map)
  end
end
