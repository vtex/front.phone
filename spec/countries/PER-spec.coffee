expect = require('chai').expect
Phone = require('../../src/script/Phone')
peru  = require('../../src/script/countries/PER')

describe 'Peru', ->

	describe 'Should format a number', ->

		it 'in national format metropolitan area phone', ->
			# Arrange
			number = "5118786565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/878 6565/)

		it 'in national format phone', ->
			# Arrange
			number = "5141786565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/786 565/)

		it 'in national fomat mobile phone', ->
			# Arrange
			number = "51987876565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/987 876 565/)

	describe 'Should get a', ->

		it 'land line number from metropolitan area', ->
			# Arrange
			number = "+51 1 878 6565"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode).to.equal('1')

		it 'land line number', ->
			# Arrange
			number = "+51 41 878 656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+51 987 876 565"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)
			expect(result.isMobile).to.be.true

	describe 'Should split', ->

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

	describe 'Should validate a', ->

		it 'land line number from metropolitan area', ->
			# Arrange
			number = "+51 1 989 6565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'land line number', ->
			# Arrange
			number = "+51 41 989 656"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+51 989 656 565"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
