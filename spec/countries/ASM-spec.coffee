expect = require('chai').expect
Phone = require('../../src/script/Phone')
country  = require('../../src/script/countries/ASM')

describe 'American Samoa', ->

	describe 'Should get', ->

		number = ''

		it 'a number', ->
			# Arrange
			number = "+1 684 9898656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('ASM')

		it 'a national number', ->
			# Arrange
			number = "(684) 123 1234"

			# Act
			result = Phone.getPhoneNational(number, '1')

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('ASM')


	describe 'Should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number', ->
			# Arrange
			number = "+1 684 9898656"

	describe 'Utility method', ->

		it 'should get the country code given the abbr', ->

			countryCode = Phone.getCountryCodeByNameAbbr('ASM')

			expect(countryCode).to.equal('1')
