expect = require('chai').expect
Phone = require('../../src/script/Phone')
brazil  = require('../../src/script/countries/BRA')

describe 'Brazil', ->

	describe 'Should format a number', ->

		phone = {}

		beforeEach ->
			# Arrange
			number = "552198986565"
			phone = Phone.getPhoneInternational(number)

		it 'in international format', ->
			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+55 21 9898 6565/)

		it 'in national format', ->
			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/\(21\) 9898\-6565/)

		it 'in local format', ->
			# Act
			result = Phone.format(phone, Phone.LOCAL)

			# Assert
			expect(result).to.match(/9898\-6565/)


	describe 'Should get a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryNameAbbr).to.equal('BRA')

		it 'standard formatted number', ->
			# Arrange
			number = "+552198986565"

		it 'specially formatted number', ->
			# Arrange
			number = "+55 (21) 9898-6565"

		it 'national destination code starting with the optional digit', ->
			# Arrange
			number = "+55 021 9898-6565"

		it 'mobile number (extra digit)', ->
			# Arrange
			number = "+55 021 998986565"

		it 'national destination code that accept nine digits but the number has only eight', ->
			# Arrange
			number = "+55 11 3111-1111"

	describe 'Should not get a', ->

		it 'phone with nine digits that doesn\'t start with nine', ->
			# Arrange
			number = "+55 11 1111-11111"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result).to.be.null

	describe 'Should split', ->

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

	describe 'Should validate a', ->

		number = ''

		afterEach ->
			# Act
			result = Phone.validate(number, "55")

			# Assert
			expect(result).to.be.true

		it 'standard formatted number', ->
			# Arrange
			number = "+552198986565"

		it 'specially formatted number', ->
			# Arrange
			number = "+55 (21) 9898-6565"

		it 'national destination code starting with the optional digit', ->
			# Arrange
			number = "+55 021 9898-6565"

		it 'mobile number (extra digit)', ->
			# Arrange
			number = "+55 021 998986565"

		it 'mobile number (extra digit, from new batch)', ->
			# Arrange
			number = "+55 31 998986565"
