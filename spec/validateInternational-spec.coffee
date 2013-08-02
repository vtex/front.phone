jasmine.getFixtures().fixturesPath = 'base/build/spec/fixtures'
jasmine.getJSONFixtures().fixturesPath = 'base/build/spec/fixtures'

describe 'Shouldn\'t validate a', ->
	
	number = ''

	afterEach ->
		# Act
		result = vtex.phone.validateInternational(number)

		# Assert
		expect(result).toBe(null)

	describe 'number with non-digits', ->		

		it 'in country code', ->
			# Arrange
			number = "+5W (21) 2343-2321"

		it 'in national destination code', ->
			# Arrange
			number = "+55 (2x1) 2343-2321"

		it 'in number', ->
			# Arrange
			number = "+55 (21) U 343-2321"			

describe 'Should validate a', ->	
	
	describe 'brazilian phone with a', ->

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
			
		it 'mobile number (extra digit)', ->
			# Arrange
			number = "+55 (021) 99898-6565"
	
	describe 'argentinian phone with a', ->

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

	describe 'uruguayan phone with a', ->

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

	describe 'chilean phone with a', ->

		number = ''

		afterEach ->
			# Act
			result = vtex.phone.validateInternational(number)

			# Assert
			expect(result.valid).toBe(true)

		it 'number with destination national code 2', ->
			# Arrange
			number = "+56 (2) 98986565"

		it 'number with 7 digits', ->
			# Arrange
			number = "+56 (35) 9898656"
		
		it 'number with 6 digits', ->
			# Arrange
			number = "+56 (35) 989865"

		it 'number with destination national code 58', ->
			# Arrange
			number = "+56 (58) 9898656"

	describe 'american phone with a', ->

		number = ''

		afterEach ->
			# Act
			result = vtex.phone.validateInternational(number)

			# Assert
			expect(result.valid).toBe(true)

		it 'number', ->
			# Arrange
			number = "+1 (201) 9898656"