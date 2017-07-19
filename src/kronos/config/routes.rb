Rails.application.routes.draw do

  get 'upload_excels', to: 'upload_excels#index'
  post 'upload_excels', to: 'upload_excels#upload'

  get 'upload_csvs', to: 'upload_csvs#index'
  post 'upload_csvs', to: 'upload_csvs#upload'

  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
