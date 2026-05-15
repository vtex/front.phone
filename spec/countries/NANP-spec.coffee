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

	describe 'Branch coverage', ->

		it 'returns undefined when withoutNDC length is not 7', ->
			# Act
			result = Phone.countries['1'].specialRules('201123', '123', '201')

			# Assert
			expect(result).to.be.undefined

		it 'returns USA when the NDC belongs to the USA list', ->
			# Act
			result = Phone.countries['1'].specialRules('2011234567', '1234567', '201')

			# Assert
			expect(result.countryNameAbbr).to.equal('USA')

		it 'returns CAN when the NDC belongs to the Canada list', ->
			# Act
			result = Phone.countries['1'].specialRules('4161234567', '1234567', '416')

			# Assert
			expect(result.countryNameAbbr).to.equal('CAN')

		it 'returns ASM when the NDC belongs to American Samoa', ->
			# Act
			result = Phone.countries['1'].specialRules('6841234567', '1234567', '684')

			# Assert
			expect(result.countryNameAbbr).to.equal('ASM')

		it 'returns DOM when the NDC belongs to Dominican Republic', ->
			# Act
			result = Phone.countries['1'].specialRules('8091234567', '1234567', '809')

			# Assert
			expect(result.countryNameAbbr).to.equal('DOM')

		it 'returns GUM when the NDC belongs to Guam', ->
			# Act
			result = Phone.countries['1'].specialRules('6711234567', '1234567', '671')

			# Assert
			expect(result.countryNameAbbr).to.equal('GUM')

		it 'returns MNP when the NDC belongs to Northern Mariana Islands', ->
			# Act
			result = Phone.countries['1'].specialRules('6701234567', '1234567', '670')

			# Assert
			expect(result.countryNameAbbr).to.equal('MNP')

		it 'returns PRI when the NDC belongs to Puerto Rico', ->
			# Act
			result = Phone.countries['1'].specialRules('7871234567', '1234567', '787')

			# Assert
			expect(result.countryNameAbbr).to.equal('PRI')

		it 'returns VIR when the NDC belongs to U.S. Virgin Islands', ->
			# Act
			result = Phone.countries['1'].specialRules('3401234567', '1234567', '340')

			# Assert
			expect(result.countryNameAbbr).to.equal('VIR')

		it 'returns the input wrapped in an array when splitNumber length is not 7', ->
			# Act
			result = Phone.countries['1'].splitNumber('123')

			# Assert
			expect(result).to.deep.equal(['123'])
