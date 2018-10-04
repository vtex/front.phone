
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.howtocallabroad.com/france/
# https://en.wikipedia.org/wiki/Telephone_numbers_in_France
class France
	constructor: ->
		@countryName = "France"
		@countryNameAbbr = "FRA"
		@countryCode = '33'
		@regex = /^(?:(?:(?:\+|)33)|)(?:0|)(?:0|)[1-9]\d{8}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['1', '2', '3', '4', '5', '6', '7', '8', '9']

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		if withoutCountryCode[0] is 0
			# Sometimes Frenchs may type their phones with a leading zero
			# we should strip that
			ndc = withoutCountryCode[1]
			withoutNDC = withoutCountryCode.slice(2)

		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if ndc in ['6', '7']
			phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
		else
			phone.isMobile = false

		return phone

	format: (phone, format) =>
		separator = @nationalNumberSeparator
		fullNumber = phone.nationalDestinationCode + phone.number

		switch format
			when Phone.NATIONAL, Phone.LOCAL
				return @splitNumber('0' + fullNumber).join(separator)
			else
				return "+" + phone.countryCode + " " + @splitNumber(fullNumber).join(separator)

	splitNumber: (number) =>
		if number.length is 10
			return Phone.compact number.split(/(\d{2})(\d{2})(\d{2})(\d{2})/)
		else if number.length is 9
			return Phone.compact number.split(/(\d{1})(\d{2})(\d{2})(\d{2})/)

		return [number]

# register
france = new France()
Phone.countries['33'] = france

# exports
module.exports = france
