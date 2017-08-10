class UploadCsvsController < ApplicationController

  def index
    @view_model = ViewModel.new()
    @view_model.title = 'CSVファイルアップロード'
    render :action => 'index'
  end

  # アップロードされたファイルの受け取り処理
  def upload

    # 社員データ
    if params[:workers]
      uploaded_file = params[:workers]
      UploadFileReceiver::storeFiles(uploaded_file)
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
