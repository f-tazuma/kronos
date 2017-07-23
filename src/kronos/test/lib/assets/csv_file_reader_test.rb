require 'test_helper'
require_relative '../../../lib/assets/csv_file_reader'

class CsvFileReaderTest < ActiveSupport::TestCase

  def setup
  end

  test 'Csv File should convert model' do
    file_path = './../../fixtures/files/source_csvs/Anken.csv'
    mapping = {0 => "no"}
    m_orders = CsvFileReader::convertCsvToObject(file_path, MOrder.new(), mapping)

  end
end
