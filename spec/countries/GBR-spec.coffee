expect = require('chai').expect
Phone = require('../../src/script/Phone')
gbr  = require('../../src/script/countries/GBR')

describe 'Great Britain', ->

	describe 'Should get a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'standard formatted number', ->
			# Arrange
			number = "+441954780888"

		it 'specially formatted number', ->
			# Arrange
			number = "+44 (20) 3000 5555"

		it 'national destination code starting with the optional digit', ->
			# Arrange
			number = "+44 020 3000 5555"

	describe 'Should split', ->

		it 'number starting with 2?, 55, 56, 70, 76 (excluding 7624) with 10 digits', ->
			# Arrange
			number = "5555555555"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

		it 'number starting with 11d, 1d1, 3dd, 9dd with 10 digits', ->
			# Arrange
			number = "1515555555"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

		it 'number starting with 1dddd with 9 or 10 digits', ->
			# Arrange
			number = "138731234"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'number starting with 1ddd with 9 or 10 digits', ->
			# Arrange
			number = "121111234"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)


		it 'number starting with 7ddd (including 7624) (not 70, 76) with 10 digits', ->
			# Arrange
			number = "7246731234"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'number starting with 800 1111 with 7 digits : UK ChildLine', ->
			# Arrange
			number = "8001111"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'number starting with 845 46 47 with 7 digits : UK NHS Direct', ->
			# Arrange
			number = "8454647"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

		it 'number starting with 84d, 87d with 10 digits', ->
			# Arrange
			number = "8451101111"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

		it 'number starting with 80d (including 800) with 10 digits', ->
			# Arrange
			number = "8001221111"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

		it 'number starting with 500, 800 with 9 digitse', ->
			# Arrange
			number = "800111223"

			# Act
			result = Phone.countries['44'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number, "44")

			# Assert
			expect(result).to.be.true

		it 'standard formatted number', ->
			# Arrange
			number = "+441954780888"

		it 'specially formatted number', ->
			# Arrange
			number = "+44 (0) 1954 780888"

		it 'national destination code starting with the optional digit', ->
			# Arrange
			number = "+44 020 3000 5555"

		it 'national formatted number', ->
			# Arrange
			number = "20 3000 5555"

		it 'mobile number', ->
			# Arrange
			number = "+447400123456"
