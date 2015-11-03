expect = require('chai').expect
Phone = require('../../src/script/Phone')
colombia  = require('../../src/script/countries/COL')

describe 'Colombia', ->

	describe 'Should format a number', ->

		it 'in international format mobile', ->
			# Arrange
			number = "573019879654"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+57 301 987 9654/)

		it 'in national format', ->
			# Arrange
			number = "5729898565"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/\(2\) 989 8565/)

		it 'in national format mobile', ->
			# Arrange
			number = "573019879654"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/301 987 9654/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+57 1 9898656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+57 301 9898656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode.length).to.equal(0)

	describe 'Should not get a', ->

		it '"almost" mobile number', ->
			# Arrange
			number = "+57 501 9898656"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null

	describe 'Should split', ->

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

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+57 1 9898656"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+57 301 9898656"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

	describe 'Should not validate an', ->

		it '"almost" mobile number from Colombia', ->
			# Arrange
			number = "+57 501 9898656"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.false
