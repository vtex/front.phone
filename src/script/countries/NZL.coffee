
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class NewZealand
	constructor: ->
		@countryName = "New Zealand"
		@countryNameAbbr = "NZL"
		@countryCode = '64'
		@regex = /^(?:(?:(?:\+|)(?:64|)|))(?:0|)(([2][0-9]{7,9})|([3,4,6,7,9][0-9]{7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["2","3","4","6","7","9"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutCountryCode[0] in ['2']
			phone.isMobile = true
			return phone
		else return phone

	splitNumber: (number) =>
		switch number.length
			when 8
				if number[0] in ['2']
					return Phone.compact number.split(/(\d{2})(\d{3})(\d{3})/)
				else return Phone.compact number.split(/(\d{1})(\d{3})(\d{4})/)
			when 9
				return Phone.compact number.split(/(\d{2})(\d{3})(\d{4})/)
			when 10
				return Phone.compact number.split(/(\d{3})(\d{3})(\d{4})/)

		return [number]

# register
newzealand = new NewZealand()
Phone.countries['64'] = newzealand

# exports
module.exports = newzealand
