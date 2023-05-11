
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/chile/
# https://www.itu.int/oth/T020200002A/en
class Chile
	constructor: ->
		@countryName = "Chile"
		@countryNameAbbr = "CHL"
		@countryCode = '56'
		@regex = /^(?:(?:\+|)56|)([2-9])\d{8}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = []

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		phone.number = withoutCountryCode
		phone.nationalDestinationCode = ''
		return phone

	splitNumber: (number) =>
		return Phone.compact number.split(/(\d{1})(\d{4})(\d{4})/)

# register
chile = new Chile()
Phone.countries['56'] = chile

# exports
module.exports = chile
