root = exports ? this

# For more info check:
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Ecuador
# http://www.howtocallabroad.com/ecuador/
class Ecuador
	constructor: ->
		@countryName = "Ecuador"
		@countryNameAbbr = "ECU"
		@countryCode = '593'
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2', '3', '4', '5', '6', '7', '9'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new vtex.phone.PhoneNumber(@countryCode, ndc, withoutNDC)
		if withoutNDC.length is 7 and ndc isnt '9'
			return phone
		else if ndc is '9'and withoutNDC.length is 8
			phone.isMobile = true
			phone.number = withoutCountryCode
			phone.nationalDestinationCode = ''
			return phone

	splitNumber: (number) =>
		if number.length is 7
			splitNumber = number.split(/(\d{3})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1
		else if number.length is 9
			if number.indexOf("9") is 0
				splitNumber = number.split(/(\d{2})(\d{3})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1

		return [number]

# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['593'] = new Ecuador()