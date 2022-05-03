expect = require('chai').expect
Phone = require('../../src/script/Phone')

describe 'Dominican Republic', ->
	it 'should validate correctly', ->
		number = '+1 809 53 55555'

		result = Phone.validate(number, '1')

		expect(result).to.be.true

	it 'should parse number to DOM', ->
		number = '+1 809 53 55555'

		result = Phone.getPhoneInternational(number)

		expect(result.countryNameAbbr).to.equal('DOM')
		expect(result.countryCode).to.equal('1')
		expect(result.nationalDestinationCode).to.equal('809')
		expect(result.number).to.equal('5355555')

	it 'should validate 829 ndc', ->
		number = '+1 829 53 55555'

		result = Phone.getPhoneInternational(number)

		expect(result.valid).to.be.true
	
	it 'should validate 849 ndc', ->
		number = '+1 849 53 55555'

		result = Phone.getPhoneInternational(number)

		expect(result.valid).to.be.true
