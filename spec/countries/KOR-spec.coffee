expect = require('chai').expect
Phone = require('../../src/script/Phone')
korea  = require('../../src/script/countries/KOR')

describe 'Korea', ->

	describe 'Should get a', ->

		it 'number', ->
			# Arrange
			number = "+82 02 3222222222222"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile', ->
			# Arrange
			number = "+82 051 3234"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "3233234"

			# Act
			result = Phone.countries['82'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile', ->
			# Arrange
			number = "63233234"

			# Act
			result = Phone.countries['82'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)
			expect(result[0].length).to.equal(4)
			expect(result[1].length).to.equal(4)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+82 0000000000"

			# Act
			result = Phone.validate(number, "82")

			# Assert
			expect(result).to.be.true

		it 'mobile', ->
			# Arrange
			number = "+82 039 3323333"

			# Act
			result = Phone.validate(number, "82")

			# Assert
			expect(result).to.be.true

	describe 'Should not', ->

		it 'get an invalid phone', ->
			# Arrange
			number = "+82 2 323"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null
