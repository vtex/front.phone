expect = require('chai').expect
Phone = require('../../src/script/Phone')
spain  = require('../../src/script/countries/ESP')

describe 'Spain', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+34 911 878 878"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+34 612 878 878"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "911878878"

			# Act
			result = Phone.countries['34'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+34 612 878 878"

			# Act
			result = Phone.validate(number, '34')

			# Assert
			expect(result).to.be.true

	describe 'Should not', ->

		it 'get an invalid number', ->
			# Arrange
			number = "+34 671 123"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null

		it 'validate an invalid number', ->
			# Arrange
			number = "+34 671 123"

			# Act
			result = Phone.validate(number, '34')

			# Assert
			expect(result).to.be.false
