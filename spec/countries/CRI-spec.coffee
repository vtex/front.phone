expect = require('chai').expect
Phone = require('../../src/script/Phone')
colombia  = require('../../src/script/countries/CRI')

describe 'Costa Rica', ->

	describe 'Should format a number', ->

		it 'in international format mobile', ->
			# Arrange
			number = "50623456789"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+506 2345 6789/)

		it 'in national format', ->
			# Arrange
			number = "50623456789"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/2345 6789/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+506 2345 6789"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+506 7345 6789"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

	describe 'Should split', ->

		it 'a number', ->
			# Arrange
			number = "23456789"

			# Act
			result = Phone.countries['506'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+506 2345 6789"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+506 7345 6789"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
