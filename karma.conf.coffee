module.exports = (config) ->
	config.set
		files: [
			'build/js/vtex-phone.js',
			'build/js/countries/**.*',
			'spec/**/*.*'
		]
		frameworks: ['jasmine']
		browsers: ['PhantomJS']
		preprocessors:
			"**/*.coffee": "coffee"