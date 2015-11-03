require('./helpers/test-helpers')

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
