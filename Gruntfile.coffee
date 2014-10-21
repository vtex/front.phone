module.exports = (grunt) ->
	pkg = grunt.file.readJSON('package.json')

	replacements =
		'VTEX_IO_HOST': 'io.vtex.com.br'
		'VERSION': pkg.version

	# Project configuration.
	grunt.initConfig
		package: grunt.file.readJSON('package.json')

		relativePath: ''

		# Tasks
		clean: 
			build: ['build']
			dist: ['dist']

		coffee:
			main:
				files: [
					expand: true
					cwd: 'src'
					src: ['**/*.coffee']
					dest: 'build/<%= relativePath %>/'
					ext: '.js'
				]

		concat:
			main:
				src: ['build/vtex-phone-core.js', 'build/countries/*.js']
				dest: 'build/vtex-phone-bundle.js'

		copy:
			dist:
				expand: true
				cwd: 'build/'
				src: ['**/*']
				dest: 'dist/'

		uglify:
			options:
			  banner: '/*! <%= package.name %> - v<%= package.version %> - <%= package.homepage %> */\n'
			main:
				files:
					'dist/vtex-phone-core.min.js':   'dist/vtex-phone-core.js'
					'dist/vtex-phone-bundle.min.js': 'dist/vtex-phone-bundle.js'
					'dist/vtex-phone-filter.min.js': 'dist/vtex-phone-filter.js'

		karma:
			unit:
				configFile: 'karma.conf.coffee'
				singleRun: true

		'gh-pages':
			options:
				base: 'build/<%= relativePath %>'
			src: ['**']

		watch:
			main:
				files: ['src/**/*', 'spec/**/*']
				tasks: ['build', 'test']

	grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-'

	grunt.registerTask 'build', ['clean:build', 'coffee', 'concat']
	grunt.registerTask 'test', ['karma:unit']

	grunt.registerTask 'default', ['build', 'test', 'watch']
	grunt.registerTask 'dist', ['build', 'test', 'clean:dist', 'copy:dist', 'uglify', 'gh-pages']
