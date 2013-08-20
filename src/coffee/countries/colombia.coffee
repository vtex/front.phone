root = exports ? this

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Colombia
class Colombia
	constructor: ->
		@countryName = "Colombia"
		@countryNameAbbr = "COL"
		@countryCode = '57'
		@mask = "[(9)][999] 999-9999"
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'3(\\d{2})', '1', '2', '3', '4', '5', '6', '7', '8'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new vtex.phone.PhoneNumber(@countryCode, '', withoutNDC)
		if withoutCountryCode.indexOf('3') is 0 and withoutCountryCode.length is 10
			phone.isMobile = true
			phone.number = withoutCountryCode
			phone.nationalDestinationCode = ''
			return phone
		else
			if withoutNDC.length is 7 then return phone

	splitNumber: (number) =>
		if number.length is 7
			splitNumber = number.split(/(\d{3})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1
		else if number.length is 10
			splitNumber = number.split(/(\d{3})(\d{3})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1

		return [number]

# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['57'] = new Colombia()