#

## railsコマンドで各種クラスを作成する
[参照](https://railsguides.jp/command_line.html#rails-generate)

### コントローラの作成
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

### migrationファイルの作成

```
$ ./bin/rails g migration MOrders
Running via Spring preloader in process 11674
      invoke  active_record
      create    db/migrate/20170808234619_m_orders.rb
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

## mysqlへの接続
+ ローカル環境
```
$ mysql -h 127.0.0.1 --port 13307 -u webapp kronos -p
```

## 多言語対応

以下のコードなどで、Validationエラーが発生した場合、
```
@project.update_attributes!(project_params)
```
対象の日本語ファイルがなく、以下のエラーとなる。

```
translation missing: ja.activerecord.errors.messages.record_invalid
```
以下のgemをインストールすることで、日本語メッセージが設定される。

```
$ cat Gemfile

gem 'rails-i18n'
```

```
バリデーションに失敗しました: Project no100は5文字以上、20文字以下
```