
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class NewZealand
	constructor: ->
		@countryName = "New Zealand"
		@countryNameAbbr = "NZL"
		@countryCode = '64'
		@regex = /^(?:(?:(?:\+|)(?:64|)|))(?:0|)(?:(?:[2][0-9]{7,9})|(?:[3,4,6,7,9][0-9]{7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["2","3","4","6","7","9"]
		@internationalFormatRegex = /^((?:\+|)(64)(?:0|))(\d{0,10})$/
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		isInternationalFormat = @internationalFormatRegex.test(withoutCountryCode)
		
		if isInternationalFormat
			countryCodeRegex = new RegExp "^"+@countryCode+'('+@optionalTrunkPrefix+'|)'
			withoutCountryCode = withoutCountryCode.replace(countryCodeRegex, "")
			ndc = withoutCountryCode[0]
			phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutCountryCode.substr 1)
			
		if withoutCountryCode[0] in ['2']
			phone.isMobile = true
			return phone
		else return phone

	format: (phone, format) =>
		return "(" + @optionalTrunkPrefix + phone.nationalDestinationCode + ") " + phone.number

	splitNumber: (number) =>
		return [number]

# register
newzealand = new NewZealand()
Phone.countries['64'] = newzealand

# exports
module.exports = newzealand
