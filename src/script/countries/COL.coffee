
Phone = require('../Phone.coffee')
PhoneNumber = require('../PhoneNumber.coffee')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Colombia
class Colombia
	constructor: ->
		@countryName = "Colombia"
		@countryNameAbbr = "COL"
		@countryCode = '57'
		@regex = /^(?:(?:\+|)57|)(?:0|)(?:(?:[12345678]\d{7})|(?:3\d{9}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'3(\\d{2})', '1', '2', '3', '4', '5', '6', '7', '8'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryCode, '', withoutNDC)
		if withoutCountryCode.indexOf('3') is 0 and withoutCountryCode.length is 10
			phone.isMobile = true
			phone.number = withoutCountryCode
			phone.nationalDestinationCode = ''
			return phone
		else
			if withoutNDC.length is 7
				phone.nationalDestinationCode = ndc
				return phone

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else if number.length is 10
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{4})/)

		return [number]

# register
colombia = new Colombia()
Phone.countries['57'] = colombia

# exports
module.exports = colombia
