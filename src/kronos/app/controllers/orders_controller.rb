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
    order_no = params[:m_order][:order_no]
    @order = MOrder.where(order_no: order_no).first
    if(@order.update_attributes(order_params))
      redirect_to action: 'index'
    else
      render :action => 'edit'
    end
  end

  private

  def order_params
    params.require(:m_order).permit(
        :order_no,
        :name,
        :client_name,
        :description,
        :ordered_date,
        :m_projects_id,
        :receiving_inspection_date,
        :order_kind,
        :sales_kind,
        :estimate_work_hours,
        :ordered_work_hours,
        :ordered_volume,
        :status,
    )
  end
end
