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
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
