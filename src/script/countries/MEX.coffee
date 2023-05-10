
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.sre.gob.mx/austin/Util/LadasMexico.html
# https://www.itu.int/oth/T020200008A/en
class Mexico
	constructor: ->
		@countryName = "Mexico"
		@countryNameAbbr = "MEX"
		@countryCode = '52'
		@regex = /^(?:(?:\+|)52|)((?:33|55|56|81\d{8})|(?:[2-9][1-9]\d{8}))$/
		@optionalTrunkPrefix = ''
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				"33","55","56","81","([2-9][1-9][0-9])"
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		if withoutNDC.length is 7 or withoutNDC.length is 8
			return new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
mexico = new Mexico()
Phone.countries['52'] = mexico

# exports
module.exports = mexico
