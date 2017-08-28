class ImportCsvsController < ApplicationController

  def index
    @view_model = ViewModel.new()
    @view_model.title = 'CSVデータ取り込み'
    render :action => 'index'
  end

  # アップロードされたファイルの受け取り処理
  def import

    # 社員データ
    if params[:workers]
      uploaded_file = params[:workers]
      file_info = UploadFileReceiver::store_file(uploaded_file)
    end

    service = ImportCsvsService.new(file_info[:file_path])
    service.import_workers
  end

  def orders
  end

  def workers
  end

  def worked_hours
  end
end
