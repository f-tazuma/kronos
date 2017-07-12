class UploadExcelsController < ApplicationController

  def index
    @view_model = ViewModel.new()
    @view_model.title = 'CSVファイルアップロード'
    render :action => 'index'
  end

  def upload
    # CSVファイルアップロード
    uploaded_io = params[:workers]


    File.open(Rails.root.join('tmp', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    service = ImportExcelService.new()
    service.test()
  end

  def orders
  end

  def workers
  end

  def worked_hours
  end
end
