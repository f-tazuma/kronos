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
      TProjectMonthlySale.destroy_all(status: "未確定")

      # テーブル:プロジェクト日次売上 からステータスが"確定"の最新行を取得 --- record(a)
      records = TProjectMonthlySale.find(status: "未確定")

      # record(a).sales_month の翌月から売上計上処理を行う


    end






  end

end