module.exports = [
    {
        entry: {
            app:        './app/assets/javascripts/app.ts',
            projects:   './app/assets/javascripts/projects/entry.ts'
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
                    test: /\.ts?$/,
                    exclude: /(node_modules|dist)/,
                    loader: 'ts-loader'
                }
            ]
        },
        resolve: {
            extensions: [ '.tsx', '.ts', '.js' ]
        }
    }
];
