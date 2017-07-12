module.exports = [
    {
        entry: {
            app: './app/assets/javascripts/entry.js'
            // style: './src/css/entry.js'
        },
        output: {
            path: __dirname + '/public/javascripts',
            filename: "[name].bundle.js",
        },
        devtool: 'source-map',
        module: {
            loaders: [
                {
                    test: /\.css$/,
                    loader: ["style-loader", "css-loader", "sass-loader"]
                },
                {
                    test: /\.scss$/,
                    loaders: ["style-loader", "css-loader", "sass-loader"]
                },
                {
                    test: /\.js?$/,
                    exclude: /(node_modules|dist)/,
                    loader: 'babel-loader',
                    query: {
                        cacheDirectory: true
                    }
                }
            ]
        },
        resolve: {
        }
    }
];