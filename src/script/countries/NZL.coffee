
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class NewZealand
	constructor: ->
		@countryName = "New Zealand"
		@countryNameAbbr = "NZL"
		@countryCode = '64'
		@regex = /^(?:(?:(?:\+|)(?:64|)(?:0|)|))([2-4,6-7,9])[0-9]{7,9}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["2","3","4","6","7","9"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if ndc in ['2']
			phone.isMobile = true
			return phone
		else return phone

	# splitNumber: (number) =>
	# 	return Phone.compact number.split(/(\d{1})(\d{4})(\d{4})/)

	# 	return [number]

	format: (phone, format = Phone.NATIONAL) =>
		resultString = ""
		fullNumber = phone.nationalDestinationCode + phone.number
		separator = @nationalNumberSeparator

		switch format
			when Phone.NATIONAL, Phone.LOCAL
				if phone.nationalDestinationCode
					resultString += '(0' + phone.nationalDestinationCode + ') '
				return resultString + @splitNumber(phone.number).join(separator)
			else
				return "+" + phone.countryCode + " " + phone.nationalDestinationCode + " " + phone.number

	splitNumber: (number) =>
		switch number.length
			when 10 
				return Phone.compact number.split(/(\d{2})(\d{4})(\d{4})/)
			when 9 
				return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)
			when 8
				return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
newzealand = new NewZealand()
Phone.countries['64'] = newzealand

# exports
module.exports = newzealand
