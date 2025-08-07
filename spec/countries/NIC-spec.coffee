expect = require('chai').expect
Phone = require('../../src/script/Phone')
nicaragua  = require('../../src/script/countries/NIC')

describe 'Nicaragua', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+505 2249 6423"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+505 7530 7717"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "22496423"

			# Act
			result = Phone.countries['505'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "84689290"

			# Act
			result = Phone.countries['505'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+505 2249 6632"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+505 8352 0536"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
