
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Australia
	constructor: ->
		@countryName = "Australia"
		@countryNameAbbr = "AUS"
		@countryCode = '61'
		@regex = /^(?:(?:(?:\+|)(?:61|)(?:0|)|))([1-5,7-8])[0-9]{8,9}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["1","2","3","4","5","7","8"]
		@mobileDestinationCode = ["4"]
		@internationalFormatRegex = /^((?:\+|)(61))(\d{0,10})$/
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		isInternationalFormat = @internationalFormatRegex.test(withoutCountryCode)

		if isInternationalFormat
			countryCodeRegex = new RegExp "^"+@countryCode+'('+@optionalTrunkPrefix+'|)'
			withoutCountryCode = withoutCountryCode.replace(countryCodeRegex, "")
			ndc = withoutCountryCode[0]
			phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutCountryCode.substr 1)
		
		if withoutCountryCode[0] in @mobileDestinationCode
			phone.isMobile = true

		return phone

	format: (phone, format = Phone.NATIONAL) =>
		resultString = ""
		fullNumber = phone.nationalDestinationCode + phone.number
		separator = @nationalNumberSeparator

		if phone.nationalDestinationCode
			isMobile = phone.nationalDestinationCode in @mobileDestinationCode
			if isMobile
				resultString += @optionalTrunkPrefix + phone.nationalDestinationCode
				resultString += @splitNumber(phone.number, isMobile).join(separator)
			else
				resultString += '(' + @optionalTrunkPrefix + phone.nationalDestinationCode + ') '
				resultString += @splitNumber(phone.number).join(separator)
			return resultString

	splitNumber: (number, isMobile = false) =>
		if number.length is 8 and isMobile
			return Phone.compact number.split(/(\d{2})(\d{3})(\d{3})/)
		else if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)
		else if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)

		return [number]

# register
australia = new Australia()
Phone.countries['61'] = australia

# exports
module.exports = australia
