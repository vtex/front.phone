expect = require('chai').expect
Phone = require('../../src/script/Phone')
france  = require('../../src/script/countries/FRA')

describe 'France', ->

	describe 'Should format a number', ->

		it 'in international format', ->
			# Arrange
			number = "33187878787"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+33 1 87 87 87 87/)

		it 'in national format', ->
			# Arrange
			number = "33187878787"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/01 87 87 87 87/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+33 1 8787 6789"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.false

		it 'mobile number', ->
			# Arrange
			number = "+33 6 8787 6789"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true

		it 'a number typed in local format', ->
			# Arrange
			number = "+33 01 8787 6789"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			# Sometimes Frenchs may type their phones with a leading zero
			# we should strip that
			expect(result.nationalDestinationCode).to.equal('1')

	describe 'Should split', ->

		it 'a number in local format', ->
			# Arrange
			number = "0123456789"

			# Act
			result = Phone.countries['33'].splitNumber(number)

			# Assert
			expect(result[0].length).to.equal(2)
			expect(result.length).to.equal(5)

		it 'a number in international format', ->
			# Arrange
			number = "123456789"

			# Act
			result = Phone.countries['33'].splitNumber(number)

			# Assert
			expect(result[0].length).to.equal(1)
			expect(result.length).to.equal(5)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+33 1 4567 6789"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+33 6 4567 6789"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'a number typed in local format', ->
			# Arrange
			number = "+33 01 4567 6789"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true
