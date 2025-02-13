expect = require('chai').expect
Phone = require('../../src/script/Phone')
portugal  = require('../../src/script/countries/PRT')

describe 'Portugal', ->

	describe 'Should format a number', ->

		it 'in international format', ->
			# Arrange
			number = "+351283609044"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+351 283 609 044/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+351 283 609 044"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.false

		it 'mobile number', ->
			# Arrange
			number = "+351 965 512 234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "283609044"

			# Act
			result = Phone.countries['351'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['283', '609', '044'])

		it 'mobile number', ->
			# Arrange
			number = "955512314"

			# Act
			result = Phone.countries['351'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['955', '512', '314'])

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+351 283 609 044"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+351 900 609 077"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
