jasmine.getFixtures().fixturesPath = 'base/build/spec/fixtures'
jasmine.getJSONFixtures().fixturesPath = 'base/build/spec/fixtures'

describe 'front.phone component', ->

	it 'should be defined', ->
		expect(vtex.phone).toBeDefined()
	
	it 'should load the countries rules', ->
		# Arrange
		countryCodeBrazil = '55'
		countryCodeUSA = '1'
		# Act
		# Assert
		expect(vtex.phone.countries[countryCodeBrazil]).toBeDefined()
		expect(vtex.phone.countries[countryCodeUSA]).toBeDefined()