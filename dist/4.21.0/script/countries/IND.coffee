
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class India
	constructor: ->
		@countryName = "India"
		@countryNameAbbr = "IND"
		@countryCode = '91'
		@regex = /^(?:\+|)(?:91|)(?:0|)*\d{10}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 10
			phone.isMobile = true
			return phone
	
	splitNumber: (number) =>
		if number.length is 10
			return Phone.compact number.split(/(\d{5})(\d{5})/)

		return [number]

# register
india = new India()
Phone.countries['91'] = india

# exports
module.exports = india
