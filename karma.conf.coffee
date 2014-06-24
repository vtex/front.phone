module.exports = (config) ->
	config.set
		files: [
			'spec/lib/angular.min.js',
			'spec/lib/angular-mock.js',
			'build/vtex-phone-bundle.js',
			'build/vtex-phone-filter.js',
			'spec/**/*.*'
		]
		frameworks: ['jasmine']
		browsers: ['PhantomJS']
