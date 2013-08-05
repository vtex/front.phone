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

	it 'should normalize number', ->
		# Arrange
		number = "+55 (21) 9898-6565"

		# Act
		result = vtex.phone.normalize(number)

		# Assert
		expect(/\D/g.test(result)).toBeFalsy()
