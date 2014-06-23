describe "front.phone filter", ->

	beforeEach module("vtex.phoneFilter")

	it "should convert boolean values to unicode checkmark or cross", inject (phoneFilter) ->
		expect(phoneFilter('552189898989')).toBe "+55 21 8989 8989"
