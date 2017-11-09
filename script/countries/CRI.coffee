
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Costa_Rica
class CostaRica
	constructor: ->
		@countryName = "Costa Rica"
		@countryNameAbbr = "CRI"
		@countryCode = '506'
		@regex = /^(?:(?:\+|)506|)(?:0|)(?:[2-8]\d{7})$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['2', '3', '4', '5', '6', '7', '8']

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, '', withoutNDC)
		if withoutCountryCode.length is 8
			if withoutCountryCode and withoutCountryCode[0] in ['5', '6', '7', '8']
				phone.isMobile = true
			phone.number = withoutCountryCode
			return phone

	splitNumber: (number) =>
		if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
costaRica = new CostaRica()
Phone.countries['506'] = costaRica

# exports
module.exports = costaRica
