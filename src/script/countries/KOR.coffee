
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.howtocallabroad.com/south-korea/
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Korea
class Korea
	constructor: ->
		@countryName = "Korea"
		@countryNameAbbr = "KOR"
		@countryCode = '82'
		@regex = /^(?:(?:(?:\+|)82)|)(?:[0]\d{5,9})$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'02',
				'051',
				'053',
				'032',
				'062',
				'042',
				'052',
				'044',
				'031',
				'033',
				'043',
				'041',
				'063',
				'061',
				'054',
				'055',
				'064'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		return new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
korea = new Korea()
Phone.countries['82'] = korea

# exports
module.exports = korea
