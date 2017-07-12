class UploadFileReceiver
  def storeFiles(file_io, store_path)
    File.open(Rails.root.join('tmp', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end


  end
end