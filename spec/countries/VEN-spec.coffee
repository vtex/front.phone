expect = require('chai').expect
Phone = require('../../src/script/Phone')
venezuela  = require('../../src/script/countries/VEN')

describe 'Venezuela', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+58 234 878 8787"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+58 418 878 8787"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "2138788787"

			# Act
			result = Phone.countries['58'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+58 234 878 8787"

			# Act
			result = Phone.validate(number, '58')

			# Assert
			expect(result).to.be.true

	describe 'Should not', ->

		it 'get an invalid number', ->
			# Arrange
			number = "+58 234 123"

			# Act
			result = Phone.getPhoneInternational(number)
			console.log result
			# Assert
			expect(result).to.be.null

		it 'validate an invalid number', ->
			# Arrange
			number = "+58 234 123"

			# Act
			result = Phone.validate(number, '58')

			# Assert
			expect(result).to.be.false
