expect = require('chai').expect
Phone = require('../../src/script/Phone')
honduras  = require('../../src/script/countries/HND')

describe 'Honduras', ->

	describe 'Should format a number', ->

		it 'in international format', ->
			# Arrange
			number = "+50422221234"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+504 2222 1234/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+504 2222 1234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.false

		it 'mobile number', ->
			# Arrange
			number = "+504 8555 1234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "22221234"

			# Act
			result = Phone.countries['504'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['2222', '1234'])

		it 'mobile number', ->
			# Arrange
			number = "75551234"

			# Act
			result = Phone.countries['504'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['7555', '1234'])

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+504 2222 1234"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+504 7555 1234"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

	describe 'Branch coverage', ->

		it 'returns null when the national number length is not 8', ->
			# Act
			result = Phone.countries['504'].specialRules('2222123', '222123', '2')

			# Assert
			expect(result).to.be.null

		it 'formats with the default branch for any other format', ->
			# Arrange
			phone = Phone.getPhoneInternational("+504 2222 1234")

			# Act
			result = Phone.countries['504'].format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/2222 1234/)

		it 'returns the input wrapped in an array when length is unsupported', ->
			# Act
			result = Phone.countries['504'].splitNumber('1234')

			# Assert
			expect(result).to.deep.equal(['1234'])
