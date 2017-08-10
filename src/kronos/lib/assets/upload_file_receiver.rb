class UploadFileReceiver
  TEMP_DIR = 'tmp';

  def self.storeFiles(file_io)
    sotre_file_info = {}
    sotre_file_info[:original_filename] = file_io.original_filename
    sotre_file_info[:size] = file_io.size

    ran

    File.open(Rails.root.join(TEMP_DIR, file_io.original_filename), 'wb') do |file|
      file.write(file_io.read)
    end
  end

  private

  def getRandomFileName
    # 一意のファイル名を生成
    pattern = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    random_string = (0...8).map { pattern[rand(pattern.length)] }.join
    return random_string
  end

end