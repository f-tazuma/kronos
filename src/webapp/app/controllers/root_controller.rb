class RootController < ApplicationController
  def index
    @title = 'トップ'
    render :action => 'index'
  end
end
