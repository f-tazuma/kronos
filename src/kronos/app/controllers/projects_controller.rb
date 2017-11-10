class ProjectsController < ApplicationController
  def index
    @title = 'プロジェクト一覧'
    @projects = MProject.all
    render :action => 'index'
  end

  def new
    @title = 'プロジェクト新規作成'
    @project = MProject.new
    render :action => 'new'
  end

  def show
    @title = 'プロジェクト詳細'
    @project = MProject.where(:id => params[:id]).first
    render :action => 'show'
  end

  def edit
    @title = 'プロジェクト編集'
    @project = MProject.where(:project_no => params[:id]).first

    # 該当プロジェクトに関連づけられている受注情報
    @related_orders = MOrder.where(:m_projects_id => @project.id)
    # 該当プロジェクトに関連づけられていない受注情報
    @non_related_orders = MOrder.where(:m_projects_id => nil)

    render :action => 'edit'
  end

  def update

    service = ProjectService.new(params)
    service.update_project

    redirect_to action: 'index'

    # project_no = params[:m_project][:project_no]
    # @project = MProject.where(project_no: project_no).first
    # if(@project.update_attributes(project_params))
    #   redirect_to action: 'index'
    # else
    #   render :action => 'edit'
    # end
  end

  def create
    @project = MProject.new(project_params)
    if @project.save
      flash[:success] = "#{@project.name}を作成しました。"
      redirect_to action: 'index'
    else
      flash[:errors] = @project.errors.full_messages
      render 'new'
    end

  end

  private

  def project_params
    params.require(:m_project).permit(
      :project_no,
      :name,
      :description,
      :work_start_date,
      :work_end_date
    )
  end
end
