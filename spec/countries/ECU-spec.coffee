expect = require('chai').expect
Phone = require('../../src/script/Phone')
ecuador  = require('../../src/script/countries/ECU')

describe 'Ecuador', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+593 2 989 6565"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+593 92 989 6565"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "2345678"

			# Act
			result = Phone.countries['593'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "912345678"

			# Act
			result = Phone.countries['593'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+593 2 989 6565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+593 92 989 6565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
