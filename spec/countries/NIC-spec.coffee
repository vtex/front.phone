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

	describe 'Branch coverage', ->

		it 'returns null when the national number length is not 8', ->
			# Arrange (call specialRules directly with wrong length)
			result = Phone.countries['505'].specialRules('2249642', '249642', '2')

			# Assert
			expect(result).to.be.null

		it 'formats an international number', ->
			# Arrange
			phone = Phone.getPhoneInternational("+505 2249 6423")

			# Act
			result = Phone.countries['505'].format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+505 2249 6423/)

		it 'formats with the default branch for any other format', ->
			# Arrange
			phone = Phone.getPhoneInternational("+505 2249 6423")

			# Act
			result = Phone.countries['505'].format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/2249 6423/)

		it 'returns the input wrapped in an array when length is unsupported', ->
			# Act
			result = Phone.countries['505'].splitNumber('1234')

			# Assert
			expect(result).to.deep.equal(['1234'])
