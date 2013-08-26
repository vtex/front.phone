root = exports ? this

# For more info check:
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Uruguay
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/uruguay/
class Uruguay
	constructor: ->
		@countryName = "Uruguay"
		@countryNameAbbr = "URY"
		@countryCode = '598'
		@regex = /^((\+|)598|)(0|)(((2|4)\d{8})|(9\d{7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2', '4', '9' # 9 is mobile
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		if (ndc.length + withoutNDC.length) is 8
			if ndc is '9'
				phone.isMobile = true
				phone.nationalDestinationCode = ''
				phone.number = withoutCountryCode
				return phone
			return new vtex.phone.PhoneNumber(@countryCode, ndc, withoutNDC)

	splitNumber: (number) =>
		if number.length is 7
			splitNumber = number.split(/(\d{3})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1
		else if number.length is 8
			splitNumber = number.split(/(\d{4})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1

		return [number]

# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['598'] = new Uruguay()