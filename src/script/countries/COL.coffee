
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Colombia
# https://www.itu.int/oth/T020200002C/en

class Colombia
	constructor: ->
		@countryName = "Colombia"
		@countryNameAbbr = "COL"
		@countryCode = '57'
		@regex = /^(?:(?:\+|)57|)(?:(?:[6][0][1245678]\d{7})|(?:3\d{9}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'3(\\d{2})', '601', '602', '604', '605', '606', '607', '608'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, '', withoutNDC)
		if withoutCountryCode.indexOf('3') is 0
			phone.isMobile = true
			phone.number = withoutCountryCode
			phone.nationalDestinationCode = ''
			return phone
		else
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
