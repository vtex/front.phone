expect = require('chai').expect
Phone = require('./helpers/require-all')

describe 'Should split', ->
	describe 'a united kingdom', ->

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


	describe 'a brazilian', ->

		it 'number with 8 digits', ->
			# Arrange
			number = "98986565"

			# Act
			result = Phone.countries['55'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'number with 9 digits only if it\'s mobile', ->
			# Arrange
			numberMobile = "998986565"
			numberNotValid = "398986565"

			# Act
			resultMobile = Phone.countries['55'].splitNumber(numberMobile)
			resultNotValid = Phone.countries['55'].splitNumber(numberNotValid)

			# Assert
			expect(resultMobile.length).to.equal(2)
			expect(resultNotValid.length).to.equal(1)

	describe 'an argentinian', ->

		describe 'land line number', ->

			number = ''

			afterEach ->
				# Act
				result = Phone.countries['54'].splitNumber(number)

				# Assert
				expect(result.length).to.equal(2)

			it 'with 8 digits', ->
				# Arrange
				number = "98986565"

			it 'with 7 digits', ->
				# Arrange
				number = "8986565"

			it 'with 6 digits', ->
				# Arrange
				number = "986565"

	describe 'an uruguayan', ->

		it 'number', ->
			# Arrange
			number = "8986565"

			# Act
			result = Phone.countries['598'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'a chilean', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.countries['56'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'number with 8 digits', ->
			# Arrange
			number = "98986565"

		it 'number with 7 digits', ->
			# Arrange
			number = "8986565"

		it 'number with 6 digits', ->
			# Arrange
			number = "986565"

	describe 'an american', ->

		it 'number', ->
			# Arrange
			number = "8986565"

			# Act
			result = Phone.countries['1'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'a colombian', ->

		it 'land line number', ->
			# Arrange
			number = "8986565"

			# Act
			result = Phone.countries['57'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "3018986565"

			# Act
			result = Phone.countries['57'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'a ecuatorian', ->

		it 'land line number', ->
			# Arrange
			number = "2345678"

			# Act
			result = Phone.countries['593'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "912345678"

			# Act
			result = Phone.countries['593'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'a peruvian', ->

		it 'land line number from metropolitan area', ->
			# Arrange
			number = "9896565"

			# Act
			result = Phone.countries['51'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'land line number', ->
			# Arrange
			number = "989898"

			# Act
			result = Phone.countries['51'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "989656989"

			# Act
			result = Phone.countries['51'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'a paraguayan', ->

		it 'number with 7 digits', ->
			# Arrange
			number = "9896565"

			# Act
			result = Phone.countries['595'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'number with 6 digits', ->
			# Arrange
			number = "896565"

			# Act
			result = Phone.countries['595'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'a mexican', ->

		it 'number with 7 digits', ->
			# Arrange
			number = "1112222"

			# Act
			result = Phone.countries['52'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['111', '2222'])

		it 'number with 8 digits', ->
			# Arrange
			number = "11112222"

			# Act
			result = Phone.countries['52'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['1111', '2222'])

