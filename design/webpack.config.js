var path = require('path')
var webpack = require('webpack')

module.exports = {
    entry: {
        app: './assets/javascripts/main.js',
    },
    output: {
        path: path.join(__dirname, 'pages'),
        filename: "[name].bundle.js",
    },
    module: {
        rules: [
            {
                test: /\.vue$/,
                loader: 'vue-loader',
            },
            {
                test: /\.js$/,
                loader: 'babel-loader?presets=es2015',
            },
            {
                test: /\.(css|sass|scss)$/,
                loader: 'sass-loader',
            },
        ]
    },
    resolve: {
        extensions: ['.js', '.vue'],
        alias: {
            vue$: 'vue/dist/vue.esm.js',
        },
    },
    devServer: {
        contentBase: 'pages',
    },
}