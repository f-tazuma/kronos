class Test01Controller < ApplicationController
  def index
    @title = '受注一覧'
    render :action => 'index'
  end

end
