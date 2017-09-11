Rails.application.routes.draw do

  # 受注情報
  get 'orders', to: 'orders#index'
  get 'orders/:id', to: 'orders#show'
  get 'orders/:id/edit', to: 'orders#edit'
  patch 'orders/:id', to: 'orders#update'

  # プロジェクト情報
  get 'projects', to: 'projects#index'
  get 'projects/:id', to: 'projects#show'
  get 'projects/:id/edit', to: 'projects#edit'
  post 'projects', to: 'projects#create'
  patch 'projects/:id', to: 'projects#update'

  # csvファイルアップロード
  get 'import_csvs', to: 'import_csvs#index'
  post 'import_csvs', to: 'import_csvs#import'

  get 'orders/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
