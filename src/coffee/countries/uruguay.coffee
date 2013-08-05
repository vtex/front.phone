window.vtex = window.vtex || {}
window.vtex.phone = window.vtex.phone || {}
window.vtex.phone.countries = window.vtex.phone.countries || {}

# For more info check:
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Uruguay
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/uruguay/
class Uruguay
	constructor: ->
		@countryCode = '598'
		@nationalTrunkPrefix = ''
		@nationalDestinationCode =
			[
				'2', '4', '9'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>		
		return (ndc.length + withoutNDC.length) is 8

	splitNumber: (number) =>
		if number.length is 7
			splitNumber = number.split(/(\d{3})(\d{4})/)
			return _.filter splitNumber, (n) => n.length >= 1

		return [number]

	format: (phone, format = vtex.phone.INTERNATIONAL) =>
		resultString = ""

		splitNumber = @splitNumber(phone.number)
		nationalNumber = phone.nationalDestinationCode + splitNumber[0] + " " + splitNumber[1]
		switch format
			when vtex.phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				resultString += nationalNumber
			when vtex.phone.NATIONAL
				resultString = nationalNumber
			when vtex.phone.LOCAL
				resultString = nationalNumber
			else
				resultString = phone.originalNumber

		return resultString


window.vtex.phone.countries['598'] = new Uruguay()