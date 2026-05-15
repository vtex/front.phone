expect = require('chai').expect
Phone = require('../src/script/Phone')
PhoneNumber = require('../src/script/PhoneNumber')
brazil  = require('../src/script/countries/BRA')
# NANP is required so getCountryCodeByNameAbbr can find the array-based abbr ("USA", "CAN", ...).
nanp = require('../src/script/countries/NANP')

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

	it 'should normalize numbers with letters, dots and slashes', ->
		# Arrange
		number = "+55/21.ABC.9898-6565"

		# Act
		result = Phone.normalize(number)

		# Assert
		expect(result).to.equal('552198986565')

	it 'should compact array removing empty strings', ->
		# Arrange
		array = ['', '11', '', '9898', '6565', '']

		# Act
		result = Phone.compact(array)

		# Assert
		expect(result).to.deep.equal(['11', '9898', '6565'])

describe 'Phone class', ->

	describe 'testCountryCode', ->

		it 'returns [true, regex] when the number starts with the country code', ->
			# Arrange
			[found, regex] = Phone.testCountryCode('55', '552198986565')

			# Assert
			expect(found).to.be.true
			expect(regex).to.be.an.instanceof(RegExp)

		it 'returns [false, null] when the number does not start with the country code', ->
			# Arrange
			[found, regex] = Phone.testCountryCode('44', '552198986565')

			# Assert
			expect(found).to.be.false
			expect(regex).to.be.null

	describe 'testNDC', ->

		it 'returns [true, regex] when the NDC matches the number', ->
			# Arrange
			[found, regex] = Phone.testNDC('21', Phone.countries['55'], '2198986565')

			# Assert
			expect(found).to.be.true
			expect(regex).to.be.an.instanceof(RegExp)

		it 'returns [false, null] when the NDC does not match the number', ->
			# Arrange
			[found, regex] = Phone.testNDC('99', Phone.countries['55'], '2198986565')

			# Assert
			expect(found).to.be.false
			expect(regex).to.be.null

	describe 'getPhoneNational', ->

		it 'returns null when nationalNumber is null', ->
			expect(Phone.getPhoneNational(null, '55')).to.be.null

		it 'returns null when the country code is unknown', ->
			expect(Phone.getPhoneNational('2198986565', '999')).to.be.null

		it 'returns null when no NDC matches and the country has an NDC list', ->
			# Arrange — Uruguay only registers NDCs ['2','4','9']; a number starting with '5' cannot match.
			result = Phone.getPhoneNational('51234567', '598')

			# Assert
			expect(result).to.be.null

		it 'returns null when specialRules rejects the number', ->
			# Arrange (Brazil expects 8 or 9 digits after the NDC; 5 digits is invalid)
			result = Phone.getPhoneNational('2112345', '55', '21')

			# Assert
			expect(result).to.be.null

		it 'uses the given national destination code when provided', ->
			# Arrange
			result = Phone.getPhoneNational('2198986565', '55', '21')

			# Assert
			expect(result.valid).to.be.true
			expect(result.nationalDestinationCode).to.equal('21')

	describe 'getPhoneInternational', ->

		it 'returns null when the number is null', ->
			expect(Phone.getPhoneInternational(null)).to.be.null

		it 'returns null when no country code matches', ->
			# Arrange (starts with 0 — not a registered country code)
			result = Phone.getPhoneInternational('00000000000')

			# Assert
			expect(result).to.be.null

		it 'returns null when the given country code does not match the number', ->
			expect(Phone.getPhoneInternational('552198986565', '44')).to.be.null

		it 'detects country and NDC without hints', ->
			# Arrange
			result = Phone.getPhoneInternational('552198986565')

			# Assert
			expect(result.valid).to.be.true
			expect(result.countryCode).to.equal('55')

	describe 'validate', ->

		it 'returns false when the number is null', ->
			expect(Phone.validate(null)).to.be.false

		it 'returns false when the number is null even with a given country code', ->
			expect(Phone.validate(null, '55')).to.be.false

		it 'returns true when at least one registered country regex matches', ->
			expect(Phone.validate('+55 21 9898-6565')).to.be.true

		it 'returns false when no registered country regex matches', ->
			expect(Phone.validate('1')).to.be.false

		it 'returns true when the given country code regex matches', ->
			expect(Phone.validate('2198986565', '55')).to.be.true

	describe 'format', ->

		it 'returns null when the phone is null', ->
			expect(Phone.format(null)).to.be.null

		it 'formats to INTERNATIONAL by default when no format is given', ->
			# Arrange
			phone = Phone.getPhoneInternational('+55 21 9898-6565')

			# Act
			result = Phone.format(phone)

			# Assert
			expect(result).to.match(/\+55 21 9898 6565/)

		it 'formats to LOCAL', ->
			# Arrange
			phone = Phone.getPhoneInternational('+55 21 9898-6565')

			# Act
			result = Phone.format(phone, Phone.LOCAL)

			# Assert
			expect(result).to.match(/9898-6565/)
			expect(result).not.to.match(/\+/)
			expect(result).not.to.match(/\(/)

		it 'formats to NATIONAL', ->
			# Arrange
			phone = Phone.getPhoneInternational('+55 21 9898-6565')

			# Act
			result = Phone.format(phone, Phone.NATIONAL)

			# Assert
			expect(result).to.match(/\(21\) 9898-6565/)

		it 'delegates to the country format function when defined', ->
			# Arrange (Argentina has its own format())
			phone = Phone.getPhoneInternational('5491198986565')

			# Act
			result = Phone.format(phone, Phone.INTERNATIONAL)

			# Assert
			expect(result).to.match(/\+54 9 11 9898 6565/)

	describe 'getCountryCodeByName', ->

		it 'returns the country code when the name matches', ->
			expect(Phone.getCountryCodeByName('Brazil')).to.equal('55')

		it 'returns undefined when the name does not match any country', ->
			expect(Phone.getCountryCodeByName('Atlantis')).to.be.undefined

	describe 'getCountryCodeByNameAbbr', ->

		it 'returns the country code when the abbreviation is a string match', ->
			expect(Phone.getCountryCodeByNameAbbr('BRA')).to.equal('55')

		it 'returns the country code when the abbreviation is inside a country abbr array', ->
			# Arrange (NANP exposes USA/CAN/etc as an array)
			result = Phone.getCountryCodeByNameAbbr('USA')

			# Assert
			expect(result).to.equal('1')

		it 'returns undefined when the abbreviation does not match anything', ->
			expect(Phone.getCountryCodeByNameAbbr('XYZ')).to.be.undefined

describe 'PhoneNumber class', ->

	it 'initializes all properties from the constructor arguments', ->
		# Arrange
		phone = new PhoneNumber('BRA', '55', '21', '98986565')

		# Assert
		expect(phone.countryNameAbbr).to.equal('BRA')
		expect(phone.countryCode).to.equal('55')
		expect(phone.nationalDestinationCode).to.equal('21')
		expect(phone.number).to.equal('98986565')
		expect(phone.isMobile).to.be.null

	it 'replaces the valid method with the boolean value after being called', ->
		# Arrange
		phone = new PhoneNumber('BRA', '55', '21', '98986565')

		# Act
		phone.valid(true)

		# Assert
		expect(phone.valid).to.be.true
