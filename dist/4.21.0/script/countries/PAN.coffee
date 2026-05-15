
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.howtocallabroad.com/panama/
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Panama
class Panama
	constructor: ->
		@countryName = "Panama"
		@countryNameAbbr = "PAN"
		@countryCode = '507'
		@regex = /^(?:(?:(?:\+|)507)|)(?:0|)(?:[23479]\d{6}|6\d{7})$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['2', '3', '4', '6', '7', '9']

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if ndc is '6' and withoutNDC.length is 7
			phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
			return phone
		else if withoutNDC.length is 6
			return phone

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
panama = new Panama()
Phone.countries['507'] = panama

# exports
module.exports = panama
