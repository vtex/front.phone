
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Australia
	constructor: ->
		@countryName = "Australia"
		@countryNameAbbr = "AUS"
		@countryCode = '61'
		@regex = /^(?:(?:(?:\+|)(?:61|)|))[1-5,7-8][0-9]{8}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["1","2","3","4","5","7","8"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutCountryCode[0] in ['4', '5']
			phone.isMobile = true
			phone.number = withoutCountryCode
			return phone
			

	splitNumber: (number) =>
		return Phone.compact number.split(/(\d{1})(\d{4})(\d{4})/)

		return [number]

# register
australia = new Australia()
Phone.countries['61'] = australia

# exports
module.exports = australia
