Rails.application.routes.draw do

  # ルート
  root to: 'root#index'

  # テスト
  get 'test01', to: 'test01#index'

  # -------------------------
  # 画面
  # -------------------------
  # 受注情報
  get 'orders', to: 'orders#index'
  get 'orders/:id', to: 'orders#show'
  get 'orders/:id/edit', to: 'orders#edit'
  patch 'orders/:id', to: 'orders#update'

  # プロジェクト情報
  get 'projects', to: 'projects#index'
  get 'projects/new', to: 'projects#new'
  get 'projects/:id', to: 'projects#show'
  get 'projects/:id/edit', to: 'projects#edit'
  post 'projects', to: 'projects#create'
  patch 'projects/:id', to: 'projects#update'

  # csvファイルアップロード
  get 'import_csvs', to: 'import_csvs#index'
  post 'import_csvs', to: 'import_csvs#import'

  # 売上
  get 'sales', to: 'sales#index'
  #   売上計上
  post 'sales/allocate_sales', to: 'sales#allocate_sales'


  # -------------------------
  # API
  # -------------------------
  namespace :api, {format: 'json'} do
    # プロジェクト詳細 初期情報取得
    get 'projects/:id', to: 'projects#show'
    # 作業予定時間登録
    post 'projects/plan-work-hours/:id', to: 'projects#store_planed_work_hours'
    # 作業者検索
    get 'workers/search', to: 'workers#search'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
