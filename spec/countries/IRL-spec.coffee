expect = require('chai').expect
Phone = require('../../src/script/Phone')
ireland  = require('../../src/script/countries/IRL')

describe 'Ireland', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+35314406692"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+353 89 608 7422"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should split', ->

		it 'land line number, 1-digit NDC', ->
			# Arrange
			number = "15355941"

			# Act
			result = Phone.countries['353'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)
		
		it 'land line number, 2-digit NDC', ->
			# Arrange
			number = "719120850"

			# Act
			result = Phone.countries['353'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)
		
		it 'land line number, 3-digit NDC', ->
			# Arrange
			number = "40221626"

			# Act
			result = Phone.countries['353'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "873823916"

			# Act
			result = Phone.countries['353'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(3)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+353 504 60818"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+353 89 989 6565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
