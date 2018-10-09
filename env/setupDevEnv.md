# 開発環境構築

## ruby、gemset設定

```text
$ echo "2.4.4" > .ruby-version
$ echo "kronos" > .rbenv-gemsets

$ rbenv versions
  system
  * 2.4.4 (set by /Users/xxx/Develop/Repos/Kronos/app/.ruby-version)
$ rbenv gemset active
kronos global
```

## railsのインストールとアプリケーションの作成

### bundlerのインストール
```text
$ rbenv exec gem install bundler
```

### railsのインストール

#### 初回のみ
```text
$ rbenv exec bundle init
Writing new Gemfile to /Users/xxx/Develop/Repos/Kronos/app/Gemfile
```
Gemfileにインストールするgemを記述。

#### gemのインストール
```text
$ brew install mysql
$ rbenv exec bundle install
```

#### アプリケーションの作成
フロントコードはrailsで管理しない。
```text
$ rails new kronos --skip-sprockets
      create  
      create  README.md
      create  Rakefile
      create  config.ru
...
```

#### サーバの起動
```text
$ rails server
=> Booting Puma
=> Rails 5.1.1 application starting in development on http://localhost:3000
...
```

## フロント開発
+ ES2015以上で記述。JSフレームワークはVueJs、Webpackでビルドする。
+ フロントコードはrailsで管理しない。

#### assetsディレクトリのクリア
```text
$ cd src/kronos/
$ rm -rf app/assets/
$ mkdir -p app/assets/javascripts
$ mkdir -p app/assets/stylesheets
```

### node設定
```
$ nodenv local 8.11.4
$ npm init
This utility will walk you through creating a package.json file.
...
```

### webpack, vue, sassなど関連パッケージインストール
```
$ npm install --save vue
$ npm install --save-dev webpack webpack-cli webpack-dev-server
$ npm install --save-dev vue-loader vue-template-compiler css-loader
$ npm install --save-dev babel-loader babel babel-core babel-preset-es2015
$ npm install --save-dev sass-loader node-sass style-loader postcss-loader
```

### scssをwebpackでビルドする
webpack4系ではmini-css-extract-pluginを利用する。
(extract-text-webpack-pluginはwebpack3まで)

```
$ npm install --save-dev mini-css-extract-plugin
```

### webpackによるビルド
package.json
```
  "scripts": {
    "webpack": "./node_modules/webpack/bin/webpack.js --progress --colors",
    "webpack:watch": "./node_modules/webpack/bin/webpack.js --progress --colors --watch"
  },
```

ビルド
```
$ npm run webpack
```

## DockerによるMySQLサーバセットアップ

### イメージの作成
```text
$ cd env/docker/mysql/
$ docker build -t kronos-mysql .
Sending build context to Docker daemon  5.12 kB
Step 1/10 : FROM mysql:5.7
...
```

### コンテナの作成
```text
$ docker run --name kronos-mysql -e MYSQL_ROOT_PASSWD=rootPwd -p 13307:3306 -d kronos-mysql
5905352d8fbac91e15691faf73949c4d9cf625481c493979ce7d0f583b36a902
```

### コンテナの起動
```
$ docker start kronos-mysql
kronos-mysql
$ docker ps

CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
2bdf42b0b645        kronos-mysql        "docker-entrypoint..."   2 minutes ago       Up About a minute   0.0.0.0:23306->3306/tcp   kronos-mysql
```

### docker-composeを利用したコンテナ作成と起動
+ コンテナの作成       
```text
$ docker-compose build
Building mysql
Step 1/5 : FROM mysql:5.7
...
```

+ コンテナの起動       
```text
$ docker-compose up
Creating kronos-mysql ... 
Creating kronos-mysql ... done
Attaching to kronos-mysql
kronos-mysql | Initializing database
kronos-mysql | 2017-08-03T15:00:51.001630Z 0 [Warning] TIMESTAMP with implicit DEFAULT value is deprecated. Please use --explicit_defaults_for_timestamp server option (see documentation for more details).
...
```

## データベース構築

### migration
```
$ rake db:migrate
```

### データ投入
```text
$ rbenv exec rake db:seed
```