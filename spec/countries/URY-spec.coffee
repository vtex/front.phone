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

	describe 'Branch coverage', ->

		it 'flags isMobile=true when NDC is "9"', ->
			# Arrange
			phone = Phone.getPhoneInternational("+598 9 1234567")

			# Assert
			expect(phone.isMobile).to.be.true

		it 'leaves isMobile unset when NDC is "2" (land line)', ->
			# Arrange
			phone = Phone.getPhoneInternational("+598 2 9898656")

			# Assert
			expect(!!phone.isMobile).to.be.false

		it 'returns undefined when the total length is not 8', ->
			# Act
			result = Phone.countries['598'].specialRules('912345', '12345', '9')

			# Assert
			expect(result).to.be.undefined

		it 'splits an 8-digit number into two groups of 4', ->
			# Act
			result = Phone.countries['598'].splitNumber('98986565')

			# Assert
			expect(result).to.deep.equal(['9898', '6565'])

		it 'returns the input wrapped in an array when length is unsupported', ->
			# Act
			result = Phone.countries['598'].splitNumber('1234')

			# Assert
			expect(result).to.deep.equal(['1234'])
