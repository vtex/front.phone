expect = require('chai').expect
Phone = require('../src/script/Phone')
brazil  = require('../src/script/countries/BRA')

describe 'front.phone component', ->

	it 'should be defined', ->
		expect(Phone).to.exist

	it 'should load the countries rules', ->
		# Arrange
		countryCodeBrazil = '55'
		countryCodeUSA = '1'

		# Act

		# Assert
		expect(Phone.countries[countryCodeBrazil]).to.exist
		expect(Phone.countries[countryCodeUSA]).to.exist

	it 'should normalize number', ->
		# Arrange
		number = "+55 (21) 9898-6565"

		# Act
		result = Phone.normalize(number)

		# Assert
		expect(/\D/g.test(result)).to.be.false
