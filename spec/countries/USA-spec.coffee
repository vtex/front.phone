expect = require('chai').expect
Phone = require('../../src/script/Phone')
usa  = require('../../src/script/countries/USA')

describe 'USA', ->

	describe 'Should get a', ->

		it 'number', ->
			# Arrange
			number = "+1 201 9898656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('USA')

	describe 'Should split', ->

		it 'number', ->
			# Arrange
			number = "8986565"

			# Act
			result = Phone.countries['1'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		it 'number', ->
			# Arrange
			number = "+1 201 9898656"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
