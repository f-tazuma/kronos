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

      service = ImportCsvsService.new(file_info[:file_path])
      service.import_workers
    end

    # 受注情報
    if params[:orders]
      uploaded_file = params[:orders]
      file_info = UploadFileReceiver::store_file(uploaded_file)

      service = ImportCsvsService.new(file_info[:file_path])
      service.import_orders
    end

    # 稼働情報
    if params[:work_hours]
      year = params[:date][:target_year].to_s
      month = params[:date][:target_month].to_s
      target_year_month = "#{year}-#{month}"

      uploaded_file = params[:work_hours]
      file_info = UploadFileReceiver::store_file(uploaded_file)

      service = ImportCsvsService.new(file_info[:file_path])
      service.import_work_hours(target_year_month)
    end

  end

  def orders
  end

  def workers
  end

  def worked_hours
  end
end
