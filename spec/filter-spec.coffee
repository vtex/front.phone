describe "front.phone filter", ->

	beforeEach module("vtex.phoneFilter")

	it "formats international phones to international format by default", inject (phoneFilter) ->
		expect(phoneFilter('552189898989')).toBe "+55 21 8989 8989"

	it "formats international phones to international format", inject (phoneFilter) ->
		expect(phoneFilter('552189898989', 'international')).toBe "+55 21 8989 8989"

	it "formats international phones to national format", inject (phoneFilter) ->
		expect(phoneFilter('552189898989', 'national')).toBe "(21) 8989-8989"

	it "formats international phones to local format", inject (phoneFilter) ->
		expect(phoneFilter('552189898989', 'local')).toBe "8989-8989"

	it "formats national phones to international format", inject (phoneFilter) ->
		expect(phoneFilter('2189898989', 'international', "55")).toBe "+55 21 8989 8989"

	it "formats national phones to national format", inject (phoneFilter) ->
		expect(phoneFilter('2189898989', 'national', "55")).toBe "(21) 8989-8989"

	it "formats national phones to local format", inject (phoneFilter) ->
		expect(phoneFilter('2189898989', 'local', "55")).toBe "8989-8989"
