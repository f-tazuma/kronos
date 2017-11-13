class ProjectService
  def initialize(params)
    @params = params
  end

  # プロジェクト情報の更新処理を行う
  def update_project

    ActiveRecord::Base.transaction do
      # プロジェクト情報の更新
      id = @params[:id]
      @project = MProject.where(id: id).first
      ret = @project.update_attributes(project_params)

      # 関連受注情報の登録
      if(@params[:non_related_orders])
        @params[:non_related_orders].each do |id|
          order = MOrder.find(id)
          order.m_projects_id = @project.id
          order.save
        end
      end

      # 関連受注情報の解除
      if(@params[:related_orders])
        @params[:related_orders].each do |id|
          order = MOrder.find(id)
          order.m_projects_id = nil
          order.save
        end
      end
    end
  end

  def project_params
    @params.require(:m_project).permit(
        :project_no,
        :name,
        :description,
        :work_start_date,
        :work_end_date
    )
  end
end