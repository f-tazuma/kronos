Rails.application.routes.draw do

  # 受注情報
  get 'orders', to: 'orders#index'
  get 'orders/:id', to: 'orders#show'

  # csvファイルアップロード
  get 'import_csvs', to: 'import_csvs#index'
  post 'import_csvs', to: 'import_csvs#import'

  get 'orders/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
