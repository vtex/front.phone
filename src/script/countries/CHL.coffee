
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/chile/
# (1) http://www.cambionumeracion.cl/?page_id=4
class Chile
	constructor: ->
		@countryName = "Chile"
		@countryNameAbbr = "CHL"
		@countryCode = '56'
		@regex = /^(?:(?:\+|)56|)([2-9])\d{8}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2','3','4','5','6','7','8','9'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		return phone

	splitNumber: (number) =>
		return Phone.compact number.split(/(\d{1})(\d{4})(\d{4})/)
		return [number]

# register
chile = new Chile()
Phone.countries['56'] = chile

# exports
module.exports = chile
