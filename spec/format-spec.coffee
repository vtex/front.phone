jasmine.getFixtures().fixturesPath = 'base/build/spec/fixtures'
jasmine.getJSONFixtures().fixturesPath = 'base/build/spec/fixtures'

describe 'Should format', ->

	describe 'a brazilian number', ->

		phone = {}

		beforeEach ->
			# Arrange
			number = "552198986565"
			phone = vtex.phone.validateInternational(number)

		it 'in international format', ->
			# Act
			result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL)

			# Assert
			expect(result).toMatch(/\+55 21 9898 6565/)

		it 'in national format', ->
			# Act
			result = vtex.phone.format(phone, vtex.phone.NATIONAL)

			# Assert
			expect(result).toMatch(/\(021\) 9898\-6565/)

		it 'in local format', ->
			# Act
			result = vtex.phone.format(phone, vtex.phone.LOCAL)

			# Assert
			expect(result).toMatch(/9898\-6565/)
