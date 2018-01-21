class SalesController < ApplicationController
  # 売上処理トップ画面
  def index
    @title = '売上処理'
    render :action => 'index'
  end

  # 売上計上処理実施画面
  def show_sales_operation

  end

  # 売上計上処理実行
  def allocate_sales

  end

  # 売上結果参照画面
  def show_project_sales

  end
end
