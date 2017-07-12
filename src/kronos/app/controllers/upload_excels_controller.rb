require_relative './../services/import_excel_service'

class UploadExcelsController < ApplicationController

  def index
    service = ImportExcelService.new()
    service.test()
    render :action => "index"
  end


  def orders
  end

  def workers
  end

  def worked_hours
  end
end
