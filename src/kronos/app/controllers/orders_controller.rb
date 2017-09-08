class OrdersController < ApplicationController
  def index
    @view_bug = {}
    @title = '受注一覧'

    @orders = MOrder.all

    render :action => 'index'
  end

  def show
    @view_bug = {}
    @title = '受注詳細'

    @order = MOrder.where(:order_no => params[:id]).first

    render :action => 'show'
  end

  def edit
    @view_bug = {}
    @title = '受注編集'

    @order = MOrder.where(:order_no => params[:id]).first

    render :action => 'edit'
  end

  def update



  end
end
