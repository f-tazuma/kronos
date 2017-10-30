# 開発環境構築

## ruby、gemset設定

```text
$ echo "2.4.1" > .ruby-version
$ echo "kronos" > .rbenv-gemsets

$ rbenv versions
  system
  * 2.4.1 (set by /Users/Yasumasa/Develop/Repos/Kronos/app/.ruby-version)
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

### assetsディレクトリのクリア
```text
$ cd src/kronos/
$ rm -rf app/assets/
$ mkdir -p app/assets/javascripts
$ mkdir -p app/assets/stylesheets
```

### nodeセットアップ

```text
$ pwd
/Users/xxx/Develop/Repos/Kronos/src/kronos
$ npm install webpack --save-dev
$ npm install watch --save-dev
$ npm install node-sass --save-dev
$ npm install css-loader file-loader sass-loader style-loader --save-dev
$ npm install babel-cli babel-core babel-loader --save-dev
$ npm install babel-preset-es2015 --save-dev
$ npm install bootstrap jquery --save-dev
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

### テーブル作成
```text
$ mysql -h 127.0.0.1 --port 13307 -u webapp kronos -p < kronos.sql 
Enter password: 
```

### データ投入
```text
$ cd ./Kronos/src/kronos
$ rbenv exec rake db:seed
```