# vue + webpack フロント開発環境

## 環境セットアップ

### node設定
```
$ nodenv local 8.5.0
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
$ npm install --save-dev sass-loader node-sass
```