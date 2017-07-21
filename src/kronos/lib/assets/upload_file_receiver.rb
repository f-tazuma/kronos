class UploadFileReceiver
  TEMP_DIR = 'tmp';

  def self.storeFiles(file_io)
    File.open(Rails.root.join(TEMP_DIR, file_io.original_filename), 'wb') do |file|
      file.write(file_io.read)
    end
  end
end