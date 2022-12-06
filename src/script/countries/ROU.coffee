
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
