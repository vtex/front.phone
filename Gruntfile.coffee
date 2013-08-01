path = require('path')
fs = require('fs')

module.exports = (grunt) ->
	pacha = grunt.file.readJSON('tools/pachamama/pachamama.config')[0]
	whoami = grunt.file.readJSON('meta/whoami')
	# Tags
	tagApplicationRoot = "&lt;%=@" + pacha.acronym + "_root%&gt;"
	tagServiceEndpoint = "&lt;%=@service_endpoint%&gt;"

	# Project configuration.
	grunt.initConfig
		# App variables
		relativePath: ''
		applicationRoot: process.env['APPLICATION_ROOT'] or whoami.roots[0]
		serviceEndpoint: process.env['SERVICE_ENDPOINT'] or 'http://service.com'
		deployDirectory: path.normalize(process.env['DEPLOY_DIRECTORY'] ? 'deploy')
		gitCommit: process.env['GIT_COMMIT'] or 'GIT_COMMIT'

		# Version variables
		acronym: pacha.acronym
		environmentName: process.env['ENVIRONMENT_NAME'] or '01-00-00'
		buildNumber: process.env['BUILD_NUMBER'] or '1'
		environmentType: process.env['ENVIRONMENT_TYPE'] or 'stable'
		versionName: -> [grunt.config('acronym'), grunt.config('environmentName'), grunt.config('buildNumber'),
										 grunt.config('environmentType')].join('-')

		# Tasks
		clean: 
			main: ['build']
			dist: ['build', 'dist']

		copy:
			main:
				expand: true
				cwd: 'src/'
				src: ['**', '!coffee/**', '!**/*.less']
				dest: 'build/<%= relativePath %>'

			debug:
				src: ['src/index.html']
				dest: 'build/<%= relativePath %>/index.debug.html'

			commit:
				expand: true
				cwd: 'build/<%= relativePath %>/'
				src: ['**', '!coffee/**', '!**/*.less']
				dest: '<%= deployDirectory %>/<%= gitCommit %>/'

			version:
				expand: true
				cwd: '<%= deployDirectory %>/<%= gitCommit %>/'
				src: ['**']
				dest: '<%= deployDirectory %>/<%= versionName() %>/'

			test: 
				expand: true
				cwd: 'spec/'
				src: ['**', '!**/*.coffee']
				dest: 'build/<%= relativePath %>/spec/'

		coffee:
			main:
				expand: true
				cwd: 'src/coffee'
				src: ['**/*.coffee']
				dest: 'build/<%= relativePath %>/js/'
				ext: '.js'

			test:
				expand: true
				cwd: 'spec/'
				src: ['**/*.coffee']
				dest: 'build/<%= relativePath %>/spec/'
				ext: '.js'

			dist:
				expand: true
				cwd: 'src/coffee'
				src: ['people.coffee']
				dest: 'dist/<%= relativePath %>/'
				ext: '.js'

		less:
			main:
				files:
					'build/<%= relativePath %>/style/main.css': 'src/style/main.less'

		useminPrepare:
			html: 'build/<%= relativePath %>/index.html'

		usemin:
			html: 'build/<%= relativePath %>/index.html'

		uglify:
			dist:
				files:
					'dist/people.min.js': ['dist/people.js']

		karma:
			options:
				configFile: 'karma.conf.js'
			unit:
				background: true
			deploy:
				singleRun: true

		'string-replace':
			# This replacement occurs in development time.
			# All service endpoints must be replaced for the app to work normally.
			dev:
				files:
					'build/<%= relativePath %>/index.html': ['build/<%= relativePath %>/index.html']

				options:
					replacements: [
						pattern: new RegExp(tagServiceEndpoint, "gi")
						replacement: '<%= serviceEndpoint %>/'
					,
						pattern: new RegExp(tagApplicationRoot, "gi")
						replacement: ''
					]
			# This replacement treats src and href attributes which cannot contain variables in order for
			# the minification process to work. It adds the applicationRoot tag variables before the files address.
			commit:
				files:
					'<%= deployDirectory %>/<%= gitCommit %>/index.html': ['<%= deployDirectory %>/<%= gitCommit %>/index.html']
					'<%= deployDirectory %>/<%= gitCommit %>/index.debug.html': ['<%= deployDirectory %>/<%= gitCommit %>/index.debug.html']

				options:
					replacements: [
						pattern: /src="(\.\.\/)?(?!http|\/|\/\/|\#|\&|\'\&)/ig
						replacement: 'src="' + tagApplicationRoot
					,
						pattern: /href="(\.\.\/)?(?!http|\/|\/\/|\#|\&|\'\&)/ig
						replacement: 'href="' + tagApplicationRoot
					,
						pattern: '<script src="http://localhost:35729/livereload.js"></script>'
						replacement: ''
					]
			# Here, all tag variables are replaced for production-ready endpoints.
			version:
				files:
					'<%= deployDirectory %>/<%= versionName() %>/index.html': ['<%= deployDirectory %>/<%= versionName() %>/index.html']
					'<%= deployDirectory %>/<%= versionName() %>/index.debug.html': ['<%= deployDirectory %>/<%= versionName() %>/index.debug.html']

				options:
					replacements: [
						pattern: new RegExp(tagServiceEndpoint, "gi")
						replacement: '<%= serviceEndpoint %>/'
					,
						pattern: new RegExp(tagApplicationRoot, "gi")
						replacement: '<%= applicationRoot %>/'
					]

		connect:
			dev:
				options:
					port: 9001
					base: 'build/'

		watch:
			options:
				livereload: true

			dev:
				files: ['src/**/*.html', 'src/**/*.coffee', 'src/**/*.js', 'src/**/*.less']
				tasks: ['dev']

			prod:
				files: ['src/**/*.html', 'src/**/*.coffee', 'src/**/*.js', 'src/**/*.less']
				tasks: ['prod']

			test:
				files: ['src/**/*.html', 'src/**/*.coffee', 'src/**/*.js', 'src/**/*.less', 'spec/**/*.*']
				tasks: ['dev', 'karma:unit:run']

	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-usemin'
	grunt.loadNpmTasks 'grunt-string-replace'
	grunt.loadNpmTasks 'grunt-karma'

	grunt.registerTask 'default', ['dev-watch']

	# Dev
	grunt.registerTask 'dev', ['clean', 'copy:main', 'copy:test', 'coffee', 'less', 'string-replace:dev']
	grunt.registerTask 'dev-watch', ['dev', 'connect', 'remote', 'watch:dev']

	# Prod - minifies files
	grunt.registerTask 'prod', ['dev', 'copy:debug', 'useminPrepare', 'concat', 'uglify', 'cssmin', 'usemin']
	grunt.registerTask 'prod-watch', ['prod', 'connect', 'remote', 'watch:prod']

	# Test
	grunt.registerTask 'test', ['dev', 'karma:deploy']
	grunt.registerTask 'test-watch', ['dev', 'karma:unit', 'watch:test']
	
	# TDD
	grunt.registerTask 'tdd', ['dev', 'connect', 'remote', 'karma:unit', 'watch:test']

	# Dist
	grunt.registerTask 'dist', ['clean', 'coffee:dist', 'uglify:dist']

	# Tasks for deploy build
	grunt.registerTask 'gen-commit', ['clean', 'copy:main', 'copy:test', 'coffee', 'less', 'copy:debug',
										'useminPrepare', 'concat', 'uglify', 'cssmin', 'usemin',
										'copy:commit', 'string-replace:commit']

	# Generates version folder
	grunt.registerTask 'gen-version', ->
		grunt.log.writeln 'applicationRoot: '.cyan + grunt.config('applicationRoot').green
		grunt.log.writeln 'serviceEndpoint: '.cyan + grunt.config('serviceEndpoint').green
		grunt.log.writeln 'environmentName: '.cyan + grunt.config('environmentName').green
		grunt.log.writeln 'buildNumber: '.cyan + grunt.config('buildNumber').green
		grunt.log.writeln 'environmentType: '.cyan + grunt.config('environmentType').green
		grunt.log.writeln 'Version deploy directory: '.cyan + (path.resolve grunt.config('deployDirectory'), grunt.config('versionName')()).green
		grunt.task.run ['copy:version', 'string-replace:version']

	# Deploy - creates deploy folder structure
	grunt.registerTask 'deploy', ->
		commit = grunt.config('gitCommit')
		deployDir = path.resolve grunt.config('deployDirectory'), commit
		deployExists = false
		grunt.log.writeln 'Commit deploy directory: '.cyan + deployDir.green
		try
			deployExists = fs.existsSync deployDir
		catch e
			grunt.log.writeln 'Error reading deploy folder'.red
			console.log e

		if deployExists
			grunt.log.writeln 'Folder '.cyan + deployDir.green + ' already exists.'.cyan
			grunt.log.writeln 'Skipping build process and generating version folder.'.cyan
			grunt.task.run ['gen-version']
		else
			grunt.task.run ['gen-commit', 'karma:deploy', 'gen-version']

	#	Remote task
	grunt.registerTask 'remote', 'Run Remote proxy server', ->
		require 'coffee-script'
		require('remote')()