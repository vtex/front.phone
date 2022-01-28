
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Singapore
	constructor: ->
		@countryName = "Singapore"
		@countryNameAbbr = "SGP"
		@countryCode = '65'
		@regex = /^(?:\+|)65\d{8,12}$/
		@optionalTrunkPrefix = ' '
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = []
		
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.indexOf("8") is 0 or withoutNDC.indexOf("9") is 0
			phone.isMobile = true
			return phone
		else if withoutNDC.length >= 8 and withoutNDC.length <= 12 then return phone
	
	splitNumber: (number) =>
		if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
singapore = new Singapore()
Phone.countries['65'] = singapore

# exports
module.exports = singapore
