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
		@initialOptionalDigit = ''
		@nationalDestinationCode =
			[
				'2', '4', '9'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>		
		return (ndc.length + withoutNDC.length) is 8			

window.vtex.phone.countries['598'] = new Uruguay()