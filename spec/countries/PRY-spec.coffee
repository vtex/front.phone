expect = require('chai').expect
Phone = require('../../src/script/Phone')
paraguay  = require('../../src/script/countries/PRY')

describe 'Paraguay', ->

	describe 'Should format a number', ->

		it 'in national format', ->
			# Arrange
			number = "595219878765"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/\(21\) 987 8765/)

		it 'in national format with 6 digits', ->
			# Arrange
			number = "59521505270"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/\(21\) 505 270/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+595 21 987 8765"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+595 992 987 8765"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true

	describe 'Should split', ->

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

	describe 'Should validate a', ->

		it 'number with 7 digits', ->
			# Arrange
			number = "+595 21 656 6565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number with 6 digits and 3 digit area code', ->
			# Arrange
			number = "+595 994 566 565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number with 6 digits and 2 digit area code padded with 0', ->
			# Arrange
			number = "+595 021 566 565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'number with 6 digits and 2 digit area code', ->
			# Arrange
			number = "+595 21 566 565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
