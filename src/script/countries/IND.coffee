Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.howtocallabroad.com/bolivia/
class India
	constructor: ->
		@countryName = "India"
		@countryNameAbbr = "IND"
		@countryCode = '91'
		@regex = /^(?:(?:(?:\+|)591)|)(?:0|)[23467]\d{7}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['6', '7', '8', '9', '0']

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 10
			if ndc in ['0']
				phone.isMobile = true
				phone.nationalDestinationCode = ''
				phone.number = withoutCountryCode
			else
				phone.isMobile = false
			return phone

	splitNumber: (number) =>
		if number.length is 10
			return Phone.compact number.split(/(\d{4})(\d{6})/)
		else if number.length is 13
			return Phone.compact number.split(/(\d{3})(\d{4})(\d{6})/)

		return [number]

# register
india = new India()
Phone.countries['91'] = inida

# exports
module.exports = india
