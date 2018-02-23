class SalesService
  def initialize(params)
    @params = params
  end

  # 売上計上処理
  def allocate_sales

    # TODO いったん全プロジェクトを対象にする
    projects = MProject.all

    # 処理対象のプロジェクトをループ
    projects.each do | project |

      # テーブル:プロジェクト日次売上 からステータスが"未確定"のデータを削除
      TProjectMonthlySale.where(m_project_id: project.id).where(status: "未確定").delete_all


      # record(a).sales_month の翌月から売上計上処理を行う
      p latest_record


    end


  end

  # プロジェクト個別の売り上げ計上処理を行う
  #   引数1: project  activerecordで取得したm_projectオブジェクト
  def allocate_project_monthly_sales(project)
    # テーブル:プロジェクト日次売上 からステータスが"確定"の最新行を取得 --- record(a)
    latest_record = TProjectMonthlySale.where(m_project_id: project.id).where(status: "確定")
                        .order(:sales_month).first()

    # 月次売り上げ情報集計
    if latest_record.blank?
      # 月次売り上げレコードがない

    else
      # 月次売り上げレコードがある

  end


end