
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://gl.wikipedia.org/wiki/N%C3%BAmeros_de_tel%C3%A9fono_en_Espa%C3%B1a
class Spain
	constructor: ->
		@countryName = "Spain"
		@countryNameAbbr = "ESP"
		@countryCode = '34'
		@regex = /^(?:(?:\+|)34|)(?:0|)(?:(?:[56789]\d{8}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'5', '6', '7', '8', '9'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, '', withoutNDC)

		if ndc is '6' or ndc is '7'
			phone.isMobile = true
			phone.number = withoutCountryCode
			phone.nationalDestinationCode = ''

		return phone

	splitNumber: (number) =>
		if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)

		return [number]

# register
spain = new Spain()
Phone.countries['34'] = spain

# exports
module.exports = spain
