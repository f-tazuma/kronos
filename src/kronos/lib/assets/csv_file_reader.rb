require 'csv'

class CsvFileReader

  def self.convertCsvToObject(csv_file_path, model, mapping)
    CSV.foreach(csv_file_path) do |row|
      puts row
    end
  end
end
