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
