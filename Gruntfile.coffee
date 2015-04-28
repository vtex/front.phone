GruntVTEX = require 'grunt-vtex'
webpack = require 'webpack'

module.exports = (grunt) ->
  pkg = grunt.file.readJSON 'package.json'
  
  # Parts of the index we wish to replace on deploy
  replaceMap = {}
  replaceMap[pkg.paths[0] + '/'] = "/"
  replaceMap['{version}'] = pkg.version

  devReplaceMap = {}
  devReplaceMap['{version}'] = "#{pkg.version}"

  defaultConfig = GruntVTEX.generateConfig grunt, pkg,
    followHttps: true
    replaceMap: replaceMap
    devReplaceMap: devReplaceMap
    livereload: !grunt.option('no-lr')
    open: false
    copyIgnore: ['!script/**/*.js', '!script/{countries}']

  delete defaultConfig.watch.coffee

  uglifyOptions =
    mangle: false
    warnings: false
    compress:
      warnings: false

  webpackPlugins = [ new webpack.optimize.CommonsChunkPlugin("vtex-phone.js") ]
  webpackPlugins = []

  # Add custom configuration here as needed
  customConfig =
    publicPath: "/<%= relativePath %>"

    concat:
      templates: {}

    copy:
      deploy:
        files = [
          expand: true
          cwd: "build/<%= relativePath %>/script/"
          src: ['**']
          dest: "dist/"
        ]

    mochaTest:
      main:
        options:
          reporter: 'spec'
        src: ['spec/**/*-spec.coffee']

    'gh-pages':
      options:
        base: 'build/<%= relativePath %>'
      src: ['**']

    uglify:
      options:
        banner: "/*! #{pkg.name} - v#{pkg.version} - #{pkg.homepage} */\n"

    watch:
      main:
        tasks: ['webpack:main', 'copy:main', 'copy:dev']

    webpack:
      options:
        module:
          loaders: [
            { test: /\.coffee$/, loader: "coffee-loader" }
            { test: /\.less$/, loader: "style!css!less" }
            { test: /\.png$/, loader: "url-loader?limit=100000" }
            { test: /\.jpg$/, loader: "file-loader" }
          ]
        devtool: "source-map"
      main:
        entry:
          "main": "./src/script/main.coffee"
          "phone-all-bundle": "./src/script/phone-all-countries.coffee"
          "phone-filter": "./src/script/phone-filter.coffee"
        output:
          path: "build/<%= relativePath %>/script/"
          publicPath: "<%= publicPath %>/script/"
          filename: "[name].js"
        plugins: webpackPlugins
        resolve:
          modulesDirectories: ["src/script/"]
          extensions: ["", ".js", ".coffee"]

  tasks =
    # Building block tasks
    build: ['clean', 'webpack:main', 'copy:main', 'copy:dev', 'copy:pkg']
    test: ['mochaTest']
    # Deploy tasks
    dist: ['clean', 'distConfig', 'webpack:main', 'copy:main', 'copy:pkg', 'copy:deploy'] # Dist - minifies files
    publish: ['build', 'test', 'gh-pages'] # Publish to Github Pages
    # Development tasks
    dev: ['nolr', 'build', 'test', 'watch']
    default: ['build', 'connect', 'test', 'watch']

  # Project configuration.
  grunt.config.init defaultConfig
  grunt.config.merge customConfig
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-' and name isnt 'grunt-vtex'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks