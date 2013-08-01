jasmine.getFixtures().fixturesPath = 'base/build/spec/fixtures'
jasmine.getJSONFixtures().fixturesPath = 'base/build/spec/fixtures'

describe 'Phone:', ->

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
	
	describe 'brazilian phone should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = vtex.phone.validateInternational(number)

			# Assert			
			expect(result.valid).toBe(true)

		it 'standard formatted number', ->
			# Arrange
			number = "+552198986565"

		it 'specially formatted number', ->
			# Arrange
			number = "+55 (21) 9898-6565"

		it 'national destination code starting with the optional digit', ->
			# Arrange
			number = "+55 (021) 9898-6565"
			
		it 'mobile number from Sao Paulo (extra digit)', ->
			# Arrange
			number = "+55 (011) 99898-6565"			
	
	describe 'argentinian phone should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = vtex.phone.validateInternational(number)

			# Assert			
			expect(result.valid).toBe(true)

		it 'an average number from Buenos Aires', ->
			# Arrange
			number = "+54 (11) 87876565"

		it 'a number with a national destination code with 3 digits', ->
			# Arrange
			number = "+54 (220) 8787656"

		it 'a mobile number', ->
			# Arrange
			number = "+54 (011) 15 87876565"

	describe 'uruguayan phone should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = vtex.phone.validateInternational(number)

			# Assert			
			expect(result.valid).toBe(true)

		it 'number with national destination code with 1 digit', ->
			# Arrange
			number = "+598 (2) 9898656"
		
		it 'number with national destination code with 3 digits', ->
			# Arrange
			number = "+598 (447) 87256"
			
		
			
		
			
		
			
			
		
	
