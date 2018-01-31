class SalesController < ApplicationController
  # 売上処理トップ画面
  def index
    @title = '売上処理'
    render :action => 'index'
  end

  # 売上計上処理実施画面
  def show_sales_operation
    @title = '売上計上処理実行'
    render :action => 'show_sales_operation'
  end

  # 売上計上処理実行
  #   売上計上処理対象のプロジェクトについて、売上データを作成する
  def allocate_sales


  end

  # 売上結果参照画面
  def show_project_sales

  end
end
