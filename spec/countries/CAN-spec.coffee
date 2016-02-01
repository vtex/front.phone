expect = require('chai').expect
Phone = require('../../src/script/Phone')
canada  = require('../../src/script/countries/CAN')

describe 'Canada', ->

	describe 'Should get', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('CAN')

		it 'a number', ->
			# Arrange
			number = "+1 204 9898656"

	describe 'Should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number', ->
			# Arrange
			number = "+1 204 9898656"

	describe 'Utility method', ->

		it 'should get the country code given the abbr', ->

			countryCode = Phone.getCountryCodeByNameAbbr('CAN')

			expect(countryCode).to.equal('1')
