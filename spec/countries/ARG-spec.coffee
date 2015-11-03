expect = require('chai').expect
Phone = require('../../src/script/Phone')
argentina  = require('../../src/script/countries/ARG')

describe 'Argentina', ->

	describe 'Should format a number', ->

		it 'in international format mobile', ->
			# Arrange
			number = "5491198986565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+54 9 11 9898 6565/)

		it 'in national format mobile', ->
			# Arrange
			number = "54111598986565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/\(11\) 15 9898\-6565/)


	describe 'Should get', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'an average number from Buenos Aires', ->
			# Arrange
			number = "+54 11 87876565"

		it 'a number with a national destination code with 3 digits', ->
			# Arrange
			number = "+54 220 8787656"

		it 'a mobile number', ->
			# Arrange
			number = "+54 9 11 87876565"

	describe 'Should split', ->

		describe 'land line number', ->

			number = ''

			afterEach ->
				# Act
				result = Phone.countries['54'].splitNumber(number)

				# Assert
				expect(result.length).to.equal(2)

			it 'with 8 digits', ->
				# Arrange
				number = "98986565"

			it 'with 7 digits', ->
				# Arrange
				number = "8986565"

			it 'with 6 digits', ->
				# Arrange
				number = "986565"

	describe 'Should validate', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'an average number from Buenos Aires', ->
			# Arrange
			number = "+54 11 87876565"

		it 'a number with a national destination code with 3 digits', ->
			# Arrange
			number = "+54 220 8787656"

		it 'a number with a rio negro destination code', ->
			# Arrange
			number = "+54 298 1234567"

		it 'a mobile number', ->
			# Arrange
			number = "+54 9 11 87876565"
