expect = require('chai').expect
Phone = require('../../src/script/Phone')
uruguay  = require('../../src/script/countries/URY')

describe 'Uruguay', ->

	describe 'Should get a', ->

		it 'number with national destination code with 1 digit', ->
			# Arrange
			number = "+598 2 989 8656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "8986565"

			# Act
			result = Phone.countries['598'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		it 'number with national destination code with 1 digit', ->
			# Arrange
			number = "+598 2 682 1202"

			# Act
			result = Phone.validate(number, "598")

			# Assert
			expect(result).to.be.true
