class OrdersController < ApplicationController
  def index
    @view_bug = {}
    @view_bug[:title] = '受注一覧'

    @view_bug[:orders] = MOrder.all

    render :action => 'index'
  end

  def show
    @view_bug = {}
    @view_bug[:title] = '受注詳細'

    @view_bug[:order] = MOrder.where(:order_no => params[:id])

    render :action => 'show'
  end
end
