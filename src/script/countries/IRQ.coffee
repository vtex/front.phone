
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Iraq
	constructor: ->
		@countryName = "Iraq"
		@countryNameAbbr = "IRQ"
		@countryCode = '964'
		@regex = /^(?:964|)(?:0|)*\d{10}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = []
	
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
iraq = new Iraq()
Phone.countries['964'] = iraq

# exports
module.exports = iraq
