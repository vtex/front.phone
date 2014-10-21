GruntVTEX = require 'grunt-vtex'

module.exports = (grunt) ->
  pkg = grunt.file.readJSON 'package.json'
  r = {}
  # Parts of the index we wish to replace on deploy
  r[pkg.paths[0] + '/'] = "/"
  r['{version}'] = pkg.version

  rDev = {}
  rDev['{version}'] = "#{pkg.version}"

  config = GruntVTEX.generateConfig grunt, pkg,
    replaceMap: r
    devReplaceMap: rDev
    replaceGlob: "build/**/index.html"
    relativePath: "front.phone"
    open: 'http://basedevmkp.vtexlocal.com.br/front.phone/'

  config.karma =
    unit:
      configFile: 'karma.conf.coffee'
      singleRun: true

  config['gh-pages'] =
    options:
      base: 'build/<%= relativePath %>'
    src: ['**']

  config.concat.templates = {}
  config.copy.deploy.files = [
    expand: true
    cwd: "build/<%= relativePath %>/script/"
    src: ['**']
    dest: "dist/"
  ]

  config.uglify.options.banner = "/*! #{pkg.name} - v#{pkg.version} - #{pkg.homepage} */\n"

  tasks =
  # Building block tasks
    build: ['clean', 'copy:main', 'copy:dev', 'coffee', 'less']
    min: ['useminPrepare', 'concat', 'uglify', 'usemin'] # minifies files
    test: ['karma:unit']
  # Deploy tasks
    dist: ['build', 'test', 'min', 'copy:deploy'] # Dist - minifies files
    publish: ['build', 'test', 'gh-pages'] # Publish to Github Pages
  # Development tasks
    dev: ['nolr', 'build', 'test', 'watch']
    default: ['build', 'connect', 'test', 'watch']
    devmin: ['build', 'min', 'connect:http:keepalive'] # Minifies files and serve
    getTags: []

  # Project configuration.
  grunt.initConfig config
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-' and name isnt 'grunt-vtex'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks