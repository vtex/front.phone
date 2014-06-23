module.exports = (config) ->
	config.set
		files: [
			'spec/lib/angular.min.js',
			'spec/lib/angular-mock.js',
			'build/js/vtex-phone.js',
			'build/js/countries/**.*',
			'build/js/vtex-phone-filter.js',
			'spec/**/*.*'
		]
		frameworks: ['jasmine']
		browsers: ['PhantomJS']
		preprocessors:
			"**/*.coffee": "coffee"