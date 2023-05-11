expect = require('chai').expect
Phone = require('../../src/script/Phone')
chile	= require('../../src/script/countries/CHL')

describe 'Chile', ->

	describe 'Should format a number', ->

		it 'in national format', ->
			# Arrange
			number = "56998986565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/9 9898 6565/)

	describe 'Should get a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'number with destination national code 2', ->
			# Arrange
			number = "+56 2 98986565"

		it 'number with destination national code 5', ->
			# Arrange
			number = "+56 5 89898656"

	describe 'Should split', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.countries['56'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

		it 'number with 9 digits', ->
			# Arrange
			number = "998986565"

	describe 'Should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number starting with 2', ->
			# Arrange
			number = "+56 2 98986565"

		it 'number starting with 5', ->
			# Arrange
			number = "+56 5 89898656"
