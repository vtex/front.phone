expect = require('chai').expect
Phone = require('../../src/script/Phone')
country  = require('../../src/script/countries/MNP')

describe 'Northern Mariana Islands', ->

	describe 'Should get', ->

		number = ''

		it 'a number', ->
			# Arrange
			number = "+1 670 9898656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('MNP')

		it 'a national number', ->
			# Arrange
			number = "(670) 123 1234"

			# Act
			result = Phone.getPhoneNational(number, '1')

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('MNP')


	describe 'Should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number', ->
			# Arrange
			number = "+1 670 9898656"

	describe 'Utility method', ->

		it 'should get the country code given the abbr', ->

			countryCode = Phone.getCountryCodeByNameAbbr('MNP')

			expect(countryCode).to.equal('1')
