window.vtex = window.vtex || {}
window.vtex.phone = window.vtex.phone || {}
window.vtex.phone.countries = window.vtex.phone.countries || {}

# For more info check:
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Uruguay
# https://www.numberingplans.com/?page=dialling&sub=areacodes
class Uruguay
	constructor: ->
		@countryCode = '598'
		@initialOptionalDigit = ''
		@nationalDestinationCode =
			[
				'433','42','447','445','464','462','477','473','472','456','453','452','434','435','444','436','463','2'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>		
		return (ndc.length + withoutNDC.length) is 8			

window.vtex.phone.countries['598'] = new Uruguay()