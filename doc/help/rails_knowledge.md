# railsナレッジ

## サービスクラスの作成
MVCのみでクラス設計を行うとModelがファットになることある。これを回避するため、サービス層を作成する。

```
app/
├── Console
├── Exceptions
├── Http
├── Models
├── Providers
├── Services    → サービス層を追加
└── User.php
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

```
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