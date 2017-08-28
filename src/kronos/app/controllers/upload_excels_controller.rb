class UploadExcelsController < ApplicationController

  def index
    @view_model = ViewModel.new()
    @view_model.title = 'エクセルファイルアップロード'
    render :action => 'index'
  end

  def upload
    # アップロードされたファイルの受け取り処理

    # 社員データ
    if params[:workers]
      uploaded_file = params[:workers]
      UploadFileReceiver::storeFiles(uploaded_file)
    end

    service = ImportCsvsService.new()
    service.test()
  end

  def orders
  end

  def workers
  end

  def worked_hours
  end
end
