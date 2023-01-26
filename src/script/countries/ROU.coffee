
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Romania
	constructor: ->
		@countryName = "Romania"
		@countryNameAbbr = "ROU"
		@countryCode = '40'
		@regex = /^(?:(?:\+|)40|)(?:0|)(?:(?:[2-7]\d{8}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = []


	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		if withoutCountryCode[0] is '0'
			# Sometimes clients may type their phones with a leading zero
			# we should strip that
			withoutNDC = withoutCountryCode.slice(1)
		
		if withoutCountryCode.slice(0,2) is '40'
			withoutNDC = withoutCountryCode.slice(2)

		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
	
		if withoutCountryCode[0] in ['6','7']
			phone.isMobile = true
			return phone
		else
			phone.isMobile = false
			return phone

	splitNumber: (number) =>
		return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)


# register
romania = new Romania()
Phone.countries['40'] = romania

# exports
module.exports = romania
