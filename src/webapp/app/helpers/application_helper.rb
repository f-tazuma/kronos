module ApplicationHelper
  def get_title(page_title)
    base_title = "アプリ名" # 自分のアプリ名を設定する
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

end
