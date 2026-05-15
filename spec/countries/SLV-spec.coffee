expect = require('chai').expect
Phone = require('../../src/script/Phone')
elsalvador  = require('../../src/script/countries/SLV')

describe 'El Salvador', ->

	describe 'Should get a', ->

		it 'land line number', ->
			# Arrange
			number = "+503 22712252"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+503 79868997"

			# Act
			result = Phone.getPhoneInternational(number)

			# Assert
			expect(result.valid).to.be.true

	describe 'Should split', ->

		it 'land line number', ->
			# Arrange
			number = "22712252"

			# Act
			result = Phone.countries['503'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

		it 'mobile number', ->
			# Arrange
			number = "79868997"

			# Act
			result = Phone.countries['503'].splitNumber(number)

			# Assert
			expect(result.length).to.equal(2)

	describe 'Should validate a', ->

		it 'land line number', ->
			# Arrange
			number = "+503 2271 2252"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

		it 'mobile number', ->
			# Arrange
			number = "+503 7986 8997"

			# Act
			result = Phone.validate(number)

			# Assert
			expect(result).to.be.true

	describe 'Branch coverage', ->

		it 'returns a non-mobile phone for a "2" NDC', ->
			# Act
			result = Phone.countries['503'].specialRules('22712252', '2712252', '2')

			# Assert
			expect(result).to.exist
			expect(!!result.isMobile).to.be.false

		it 'flags isMobile=true for a "6" NDC', ->
			# Act
			result = Phone.countries['503'].specialRules('62712252', '2712252', '6')

			# Assert
			expect(result.isMobile).to.be.true

		it 'returns undefined when withoutNDC length is not 7', ->
			# Act
			result = Phone.countries['503'].specialRules('227122', '227122', '2')

			# Assert
			expect(result).to.be.undefined

		it 'returns the input wrapped in an array when length is unsupported', ->
			# Act
			result = Phone.countries['503'].splitNumber('123')

			# Assert
			expect(result).to.deep.equal(['123'])
