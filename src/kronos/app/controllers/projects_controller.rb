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
    render :action => 'edit'
  end

  def update
    project_no = params[:m_project][:project_no]
    @project = MProject.where(project_no: project_no).first
    if(@project.update_attributes(project_params))
      redirect_to action: 'index'
    else
      render :action => 'edit'
    end
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
