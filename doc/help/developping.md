#

## railsコマンドで各種クラスを作成する
[参照](https://railsguides.jp/command_line.html#rails-generate)

#### コントローラの作成
+ 書式
`rails generate controller コントローラ名 メソッド1 メソッド2`

```
$ rails generate controller UploadExcels orders workers worked_hours

class UploadExcelsController < ApplicationController
  def orders
  end

  def workers
  end

  def worked_hours
  end
end

```

## rails generate でassets, helpersを生成しない
rails generateコマンドを利用すると、assetsやhelpersに初期ファイルが生成される。
これを止めるためには、config.generatorsを下記のように設定する。


```
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
  end
```
