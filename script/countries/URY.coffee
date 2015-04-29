
Phone = require('../Phone.coffee')
PhoneNumber = require('../PhoneNumber.coffee')

# For more info check:
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Uruguay
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/uruguay/
class Uruguay
	constructor: ->
		@countryName = "Uruguay"
		@countryNameAbbr = "URY"
		@countryCode = '598'
		@regex = /^(?:(?:\+|)598|)(?:0|)(?:[249]\d{7})$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2', '4', '9' # 9 is mobile
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryCode, ndc, withoutNDC)
		if (ndc.length + withoutNDC.length) is 8
			if ndc is '9'
				phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
			return phone

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
uruguay = new Uruguay()
Phone.countries['598'] = uruguay

# exports
module.exports = uruguay
