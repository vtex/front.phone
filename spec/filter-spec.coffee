# Prepare Angular test infrastructure
jsdom = require('jsdom').jsdom

global.document = jsdom('<html><head><script></script></head><body></body></html>')
global.window = global.document.defaultView
global.navigator = window.navigator = {}

global.window.mocha = {}
global.window.beforeEach = beforeEach
global.window.afterEach = afterEach

require('angular/angular')
require('angular-mocks')

global.angular = window.angular
global.inject = global.angular.mock.inject
global.ngModule = global.angular.mock.module

# Now our tests
expect = require('chai').expect
Phone = require('../src/script/Phone')
brazil  = require('../src/script/countries/BRA')

require('../src/script/phone-filter')

window.vtex = {}
window.vtex.phone = Phone

describe "front.phone filter", ->

	beforeEach ngModule("vtex.phoneFilter")

	it "formats international phones to international format by default", inject (phoneFilter) ->
		expect(phoneFilter('552189898989')).to.match(/\+55 21 8989 8989/)

	it "formats international phones to international format", inject (phoneFilter) ->
		expect(phoneFilter('552189898989', 'international')).to.match(/\+55 21 8989 8989/)

	it "formats international phones to national format", inject (phoneFilter) ->
		expect(phoneFilter('552189898989', 'national')).to.match(/\(21\) 8989\-8989/)

	it "formats international phones to local format", inject (phoneFilter) ->
		expect(phoneFilter('552189898989', 'local')).to.match(/8989\-8989/)

	it "formats national phones to international format", inject (phoneFilter) ->
		expect(phoneFilter('2189898989', 'international', "55")).to.match(/\+55 21 8989 8989/)

	it "formats national phones to national format", inject (phoneFilter) ->
		expect(phoneFilter('2189898989', 'national', "55")).to.match(/\(21\) 8989\-8989/)

	it "formats national phones to local format", inject (phoneFilter) ->
		expect(phoneFilter('2189898989', 'local', "55")).to.match(/8989\-8989/)
