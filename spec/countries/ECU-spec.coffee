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

	describe 'Branch coverage', ->

		it 'returns undefined when withoutNDC length is 7 but NDC is "9"', ->
			# Act
			result = Phone.countries['593'].specialRules('91234567', '1234567', '9')

			# Assert
			expect(result).to.be.undefined

		it 'returns undefined when NDC is "9" but withoutNDC length is not 8', ->
			# Act
			result = Phone.countries['593'].specialRules('9123456', '123456', '9')

			# Assert
			expect(result).to.be.undefined

		it 'splits a 9-digit number that does NOT start with 9 by leaving it intact', ->
			# Act
			result = Phone.countries['593'].splitNumber('212345678')

			# Assert
			expect(result).to.deep.equal(['212345678'])

		it 'returns the input wrapped in an array when length is unsupported', ->
			# Act
			result = Phone.countries['593'].splitNumber('123')

			# Assert
			expect(result).to.deep.equal(['123'])
