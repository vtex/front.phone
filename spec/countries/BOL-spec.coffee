expect = require('chai').expect
Phone = require('../../src/script/Phone')
bolivia  = require('../../src/script/countries/BOL')

describe 'Bolivia', ->

expect = require('chai').expect
Phone = require('../../src/script/Phone')
uruguay  = require('../../src/script/countries/URY')

describe 'Bolivia', ->

	describe 'Should get a', ->

		it 'number', ->
			# Arrange
			number = "+591 2 323 3234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile', ->
			# Arrange
			number = "+591 7 323 3234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.isMobile).to.be.true
			expect(result.valid).to.be.true

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "3233234"

			# Act
			result = Phone.countries['591'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile', ->
			# Arrange
			number = "73233234"

			# Act
			result = Phone.countries['591'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)
			expect(result[0].length).to.equal(3)
			expect(result[1].length).to.equal(5)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+591 2 323 3234"

			# Act
			result = Phone.validate(number, "591")

			# Assert
			expect(result).to.be.true

		it 'mobile', ->
			# Arrange
			number = "+591 7 323 3234"

			# Act
			result = Phone.validate(number, "591")

			# Assert
			expect(result).to.be.true
