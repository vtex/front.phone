module.exports = (config) ->
	config.set
		files: [
			'spec/lib/angular.min.js',
			'spec/lib/angular-mock.js',
			'build/front.phone/script/vtex-phone-core.js',
			'build/front.phone/script/countries/**.*',
			'build/front.phone/script/vtex-phone-filter.js',
			'spec/**/*.*'
		]
		frameworks: ['jasmine']
		browsers: ['PhantomJS']
