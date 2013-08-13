root = exports ? this

# For more info check:
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Uruguay
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/uruguay/
class Uruguay
	constructor: ->
		@countryCode = '598'
		@optionalTrunkPrefix = ''
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2', '4', '9'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>
		if (ndc.length + withoutNDC.length) is 8
			return new vtex.phone.PhoneNumber(@countryCode, ndc, withoutNDC, originalNumber)

	splitNumber: (number) =>
		if number.length is 7
			splitNumber = number.split(/(\d{3})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1

		return [number]

# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['598'] = new Uruguay()