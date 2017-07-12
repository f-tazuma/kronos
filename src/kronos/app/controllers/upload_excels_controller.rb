class UploadExcelsController < ApplicationController

  def index
    @view_model = ViewModel.new()
    @view_model.title = 'CSVファイルアップロード'
    render :action => 'index'
  end

  def upload
    # CSVファイルアップロード

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
