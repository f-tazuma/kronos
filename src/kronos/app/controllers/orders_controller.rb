class OrdersController < ApplicationController
  def index
    @view_bug = {}
    @view_bug[:title] = '受注一覧'

    @view_bug[:orders] = MOrder.all

    render :action => 'index'
  end
end
