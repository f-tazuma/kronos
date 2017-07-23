# railsナレッジ

## サービスクラスの作成
MVCのみでクラス設計を行うとModelがファットになることある。これを回避するため、サービス層を作成する。

```
app/
├── assets
├── channels
├── controllers
├── helpers
├── jobs
├── mailers
├── models
├── services    → サービス層(ディレクトリ)を追加
└── views
```

```ruby
class ImportExcelService
  def test()
    puts "test"
  end
end
```

コントローラでサービスを利用する際に、requireをする必要がある。（当たり前といえば当たり前。）
```ruby
require_relative './../services/import_excel_service'

class UploadExcelsController < ApplicationController

  def index
    service = ImportExcelService.new()
    service.test()
    render :action => "index"
  end
end
```

## サービスクラスを自動ロードする
config/application.rbにautoloadするパスを追加する。    
config.autoload_paths += %W(#{config.root}/app/services)

```ruby
module Kronos
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.assets = false
      g.helper = false
    end

    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
```

autoloadがされていると、requireをしなくても、サービスクラスを利用可能。
```
# require_relative './../services/import_excel_service'

class UploadExcelsController < ApplicationController

  def index
    service = ImportExcelService.new()
    service.test()
    render :action => "index"
  end
end
```

## テストの実行方法
### テストの実行
```
$ rbenv exec rake test
```

### 特定のテストファイルを指定してテストを実行する
```
$ rake test TEST=test/lib/assets/csv_file_reader_test.rb
```

## Excelファイルの取り扱い
rubyでExcelファイルを扱うためのライブラリは複数あるようだが、以下のライブラリを利用してみる。
https://github.com/weshatheleopard/rubyXL

