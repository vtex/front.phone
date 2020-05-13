expect = require('chai').expect
Phone = require('../../src/script/Phone')
country  = require('../../src/script/countries/NANP')

describe 'NANP', ->

	describe 'Should validate', ->

		it 'all NANP NDCs', ->
			# Arrange
			prefix = "+1 "
			suffix = " 9898656"

			# Act
			for ndc in Phone.countries['1'].nationalDestinationCode
				number = prefix + ndc + suffix
				result = Phone.validate(number)

				# Assert
				if !result
					console.log 'NDC missing: ', ndc
				expect(result).to.be.true
