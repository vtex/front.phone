expect = require('chai').expect
Phone = require('../../src/script/Phone')
spain  = require('../../src/script/countries/ITA')

describe 'Italy', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+39 06 8120297"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+39 328 4823922"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should format a number', ->

		it 'in international format', ->
			# Arrange
			number = "39068120297"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+39 06 8120297/)

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "068120297"

			# Act
			result = Phone.countries['39'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+39 06 8120297"

			# Act
			result = Phone.validate(number, '39')

			# Assert
			expect(result).to.be.true

	describe 'Should not', ->

		it 'get an invalid number', ->
			# Arrange
			number = "+39 06 712"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null

		it 'validate an invalid number', ->
			# Arrange
			number = "+39 06 712"

			# Act
			result = Phone.validate(number, '39')

			# Assert
			expect(result).to.be.false
