jasmine.getFixtures().fixturesPath = 'base/build/spec/fixtures'
jasmine.getJSONFixtures().fixturesPath = 'base/build/spec/fixtures'

describe 'Should format', ->

	describe 'an uruguayan number', ->

		phone = {}

		beforeEach ->
			# Arrange
			number = "59828986565"
			phone = vtex.phone.validateInternational(number)

		it 'in the international format', ->
			# Act
			result = vtex.phone.format(phone)

			# Assert
			expect(result).toMatch(/\+598 2898 6565/)

		it 'in the national format', ->
			# Act
			result = vtex.phone.format(phone, vtex.phone.NATIONAL)

			# Assert
			expect(result).toMatch(/2898 6565/)
		
		it 'in the local format', ->
			# Act
			result = vtex.phone.format(phone, vtex.phone.LOCAL)

			# Assert
			expect(result).toMatch(/2898 6565/)
	
		