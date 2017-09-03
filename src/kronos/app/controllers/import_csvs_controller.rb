class ImportCsvsController < ApplicationController

  def index
    @view_bug = {}
    @view_bug[:title] = 'CSVデータ取り込み'

    @view_bug[:target_date_start] = Date.today.at_beginning_of_year()
    @view_bug[:target_date_end] = Date.today.at_end_of_month()

    render :action => 'index'
  end

  # アップロードされたファイルの受け取り処理
  def import
    flash[:notice] = []

    # 社員情報
    if params[:workers]
      uploaded_file = params[:workers]
      file_info = UploadFileReceiver::store_file(uploaded_file)

      service = ImportCsvsService.new(file_info[:file_path])
      count = service.import_workers

      flash[:notice] << "社員情報: #{count} 件登録"
    end

    # 受注情報
    if params[:orders]
      uploaded_file = params[:orders]
      file_info = UploadFileReceiver::store_file(uploaded_file)

      service = ImportCsvsService.new(file_info[:file_path])
      count = service.import_orders

      flash[:notice] << "受注情報: #{count} 件登録"
    end

    # 稼働情報
    if params[:work_hours]
      start_date = params[:target_date][:start]
      end_date = params[:target_date][:end]

      uploaded_file = params[:work_hours]
      file_info = UploadFileReceiver::store_file(uploaded_file)

      service = ImportCsvsService.new(file_info[:file_path])
      count = service.import_work_hours(start_date, end_date)

      flash[:notice] << "稼働情報: #{count} 件登録"
    end

    redirect_to action: 'index'
  end

end
