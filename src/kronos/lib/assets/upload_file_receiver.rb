class UploadFileReceiver

  TEMP_DIR = 'tmp';

  def self.store_file(file_io)
    random_file_name = get_random_file_name

    store_file_info = {}
    store_file_info[:original_filename] = file_io.original_filename
    store_file_info[:size] = file_io.size
    store_file_info[:file_name] = random_file_name
    store_file_info[:file_path] = Rails.root.join(TEMP_DIR, store_file_info[:file_name])

    File.open(Rails.root.join(store_file_info[:file_path]), 'wb') do |file|
      file.write(file_io.read)
    end

    return store_file_info

  end

  def self.get_random_file_name
    # 一意のファイル名を生成
    pattern = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    random_string = (0...8).map { pattern[rand(pattern.length)] }.join
    return random_string
  end

  private_class_method :get_random_file_name
end