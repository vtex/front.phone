expect = require('chai').expect
Phone = require('../../src/script/Phone')
honduras  = require('../../src/script/countries/AGO')

describe 'Angola', ->

	describe 'Should format a number', ->

		it 'in international format', ->
			# Arrange
			number = "+244226434517"
			phone = Phone.getPhoneInternational(number)

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+244 226 434 517/)

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+244 226 434 517"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.false

		it 'mobile number', ->
			# Arrange
			number = "+244923434528"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true
			expect(result.isMobile).to.be.true

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "226434517"

			# Act
			result = Phone.countries['244'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['226', '434', '517'])

		it 'mobile number', ->
			# Arrange
			number = "923434528"

			# Act
			result = Phone.countries['244'].splitNumber(number)

			# Assert
			expect(result).to.deep.equal(['923', '434', '528'])

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+244 226 434 517"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+244 923 434 528"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

	describe 'Branch coverage', ->

		it 'returns null when the national number length is not 9', ->
			# Act
			result = Phone.countries['244'].specialRules('22643451', '2643451', '2')

			# Assert
			expect(result).to.be.null

		it 'detects a 3-digit mobile prefix (slice(0,3))', ->
			# Arrange (923 is a 3-char mobile prefix)
			phone = Phone.getPhoneInternational("+244923434528")

			# Assert
			expect(phone.isMobile).to.be.true

		it 'detects a 2-digit mobile prefix (slice(0,2))', ->
			# Arrange (91 is a 2-char mobile prefix)
			phone = Phone.getPhoneInternational("+244913434528")

			# Assert
			expect(phone.isMobile).to.be.true

		it 'formats with the default branch for any other format', ->
			# Arrange
			phone = Phone.getPhoneInternational("+244 226 434 517")

			# Act
			result = Phone.countries['244'].format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/226 434 517/)

		it 'returns the input wrapped in an array when length is unsupported', ->
			# Act
			result = Phone.countries['244'].splitNumber('1234')

			# Assert
			expect(result).to.deep.equal(['1234'])
