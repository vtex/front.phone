expect = require('chai').expect
Phone = require('../../src/script/Phone')
spain  = require('../../src/script/countries/GRC')

describe 'Greece', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+302310722297"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+306972148716"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+302310722297"

			# Act
			result = Phone.validate(number, '30')

			# Assert
			expect(result).to.be.true

	describe 'Should not', ->

		it 'get an invalid number', ->
			# Arrange
			number = "+390"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null

		it 'validate an invalid number', ->
			# Arrange
			number = "+30069"

			# Act
			result = Phone.validate(number, '30')

			# Assert
			expect(result).to.be.false
