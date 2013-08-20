module.exports = (config) ->
	config.set
		files: [
			'build/lib/jquery/jquery.js',
			'build/lib/underscore/underscore.js',
			'build/spec/helpers/jasmine-jquery.js',
			'build/js/vtex-phone.js',
			'build/js/countries/**.*',
			'spec/**/*.*'
		]
		frameworks: ['jasmine']
		browsers: ['PhantomJS']
		preprocessors:
			"**/*.coffee": "coffee"