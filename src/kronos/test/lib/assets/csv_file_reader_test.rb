require 'test_helper'

class CsvFileReaderTest < ActiveSupport::TestCase

  def setup
    @csv_file_reader = new CsvFileReader
  end

  test 'Csv File should convert model' do
    assert CsvFileReader::convertCsvToObject()

  end
end