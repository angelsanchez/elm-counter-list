var path = require('path')
var webpack = require('webpack')
var merge = require('webpack-merge')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var autoprefixer = require('autoprefixer')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var CopyWebpackPlugin = require('copy-webpack-plugin')
var BrowserSyncPlugin = require('browser-sync-webpack-plugin')

console.log('WEBPACK GO!')

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development'

// common webpack config
var commonConfig = {

  output: {
    path: path.resolve(__dirname, 'dist/'),
    filename: '[hash].js'
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm']
    
  },

  module: {
    noParse: /\.elm$/,
    loaders: [
      {
        test: /\.(eot|ttf|woff|woff2|svg)$/,
        loader: 'file-loader'
      },
      {
        test: /\.(jpe?g|png|gif|svg)$/i,
        loaders: [
          'file?hash=sha512&digest=hex&name=[hash].[ext]',
          'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
        ]
      }
    ]
  },

  plugins: [
    new CopyWebpackPlugin([
      { from: 'src/static/images/', to: '/static/images/' },
      { from: 'src/static/favicon.ico' },
      { from: 'src/static/manifest.json', to: '/static/' },
      { from: 'src/static/service-worker.js', to: '/' }
    ]),
    new HtmlWebpackPlugin({
      template: 'src/static/index.html',
      inject: 'body',
      filename: 'index.html'
    }),
    new BrowserSyncPlugin({
      host: 'localhost',
      port: 8081,
      open: false,
      proxy: 'http://localhost:8080/'
    },
      // plugin options
      {
        // prevent BrowserSync from reloading the page
        // and let Webpack Dev Server take care of this
        reload: false
      })
  ],

  postcss: [autoprefixer({ browsers: ['last 2 versions'] })]

}

// additional webpack settings for local env (when invoked by 'npm start')
if (TARGET_ENV === 'development') {
  console.log('Serving locally...')

  module.exports = merge(commonConfig, {
    watch: true,

    output: {
      path: 'src/static/',
      publicPath: '/'
    },

    entry: [
      'webpack-dev-server/client?http://localhost:8080',
      path.join(__dirname, 'src/static/index-dev.js')
    ],

    devServer: {
      inline: true,
      progress: true,
      stats: { colors: true }
    },

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-hot!elm-webpack?verbose=true&warn=true'
        },
        {
          test: /\.(css|scss)$/,
          loaders: [
            'style-loader',
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ]
        }
      ]
    }

  })
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'production') {
  console.log('Building for prod...')

  module.exports = merge(commonConfig, {

    entry: path.join(__dirname, 'src/static/index.js'),

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack'
        },
        {
          test: /\.(css|scss)$/,
          loader: ExtractTextPlugin.extract('style-loader', [
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ])
        }
      ]
    },

    plugins: [
      new CopyWebpackPlugin([
        { from: 'src/static/images/', to: 'static/images/' },
        { from: 'src/static/favicon.ico' },
        { from: 'src/static/manifest-gh-pages.json', to: 'static/manifest.json' },
        { from: 'src/static/service-worker.js' }
      ]),

      new webpack.optimize.OccurenceOrderPlugin(),

      // extract CSS into a separate file
      new ExtractTextPlugin('./[hash].css', { allChunks: true }),

      // minify & mangle JS/CSS
      new webpack.optimize.UglifyJsPlugin({
        minimize: true,
        compressor: { warnings: false }
        // mangle:  true
      })
    ]

  })
}
