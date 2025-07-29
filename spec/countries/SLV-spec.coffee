expect = require('chai').expect
Phone = require('../../src/script/Phone')
elsalvador  = require('../../src/script/countries/SLV')

describe 'El Salvador', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+503 22712252"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+503 79868997"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "22712252"

			# Act
			result = Phone.countries['503'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "79868997"

			# Act
			result = Phone.countries['503'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+503 2271 2252"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+503 7986 8997"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
