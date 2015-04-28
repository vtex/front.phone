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

  webpackPlugins = [ new webpack.optimize.CommonsChunkPlugin("vtex-phone.js") ]
  webpackPlugins = []

  # Add custom configuration here as needed
  customConfig =
    publicPath: "/<%= relativePath %>"

    concat:
      templates: {}

    mochaTest:
      main:
        options:
          reporter: 'spec'
        src: ['spec/**/*-spec.coffee']

    'gh-pages':
      options:
        base: 'build/<%= relativePath %>'
      src: ['**']

    coffee:
      dist:
        files: [
          expand: true
          cwd: 'src/script'
          src: ['**/*.coffee']
          dest: "./"
          rename: (path, filename) ->
            path + filename.replace("coffee", "js")
        ]

    watch:
      coffee:
        files: ['src/script/**/*.coffee']
        tasks: ['coffee:main']
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
    dist: ['build', 'test', 'coffee:dist'] # Dist
    publish: ['build', 'test', 'gh-pages'] # Publish to Github Pages
    # Development tasks
    dev: ['nolr', 'build', 'test', 'watch']
    default: ['build', 'connect', 'test', 'watch']

  # Project configuration.
  grunt.config.init defaultConfig
  grunt.config.merge customConfig
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-' and name isnt 'grunt-vtex'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks