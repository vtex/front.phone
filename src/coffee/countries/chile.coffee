window.vtex = window.vtex || {}
window.vtex.phone = window.vtex.phone || {}
window.vtex.phone.countries = window.vtex.phone.countries || {}

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
class Chile
	constructor: ->
		@countryCode = '56'
		@initialOptionalDigit = ''
		@nationalDestinationCode =
			[
				'2','32','33','34','35','41','42','43','45','51','52','53','55','57','58','61','63','64','65','67','68','71','72','73','75'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>
		switch ndc
			when '2'
				return withoutNDC.length is 8
			when '58'
				return withoutNDC.length is 7
			else
				return withoutNDC.length is 6 or withoutNDC.length is 7

window.vtex.phone.countries['56'] = new Chile()