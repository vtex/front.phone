expect = require('chai').expect
Phone = require('../../src/script/Phone')
panama  = require('../../src/script/countries/PAN')

describe 'Panama', ->

	describe 'Should get a', ->

		it 'number', ->
			# Arrange
			number = "+507 232 3234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile', ->
			# Arrange
			number = "+507 6323 3234"

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
			result = Phone.countries['507'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile', ->
			# Arrange
			number = "63233234"

			# Act
			result = Phone.countries['507'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)
			expect(result[0].length).to.equal(4)
			expect(result[1].length).to.equal(4)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+507 30000000000"

			# Act
			result = Phone.validate(number, "507")

			# Assert
			expect(result).to.be.true

		it 'mobile', ->
			# Arrange
			number = "+507 6323 3234"

			# Act
			result = Phone.validate(number, "507")

			# Assert
			expect(result).to.be.true

	describe 'Should not', ->

		it 'get an invalid phone', ->
			# Arrange
			number = "+507 2 323"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null
