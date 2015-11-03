
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.howtocallabroad.com/bolivia/
class Bolivia
	constructor: ->
		@countryName = "Bolivia"
		@countryNameAbbr = "BOL"
		@countryCode = '591'
		@regex = /^(?:(?:(?:\+|)591)|)(?:0|)(?:(?:(?:[234]|)\d{7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2', '3', '4',
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		return phone

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)

		return [number]

# register
bolivia = new Bolivia()
Phone.countries['591'] = bolivia

# exports
module.exports = bolivia
