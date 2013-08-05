window.vtex = window.vtex || {}
window.vtex.phone = window.vtex.phone || {}
window.vtex.phone.countries = window.vtex.phone.countries || {}

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/chile/
# (1) http://www.cambionumeracion.cl/?page_id=4
class Chile
	constructor: ->
		@countryCode = '56'
		@optionalTrunkPrefix = ''
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2','32','33','34','35','41','42','43','45','51','52','53','55','57','58','61','63','64','65','67','68','71','72','73','75', '9' # 9 is a mobile number
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>
		switch ndc
			when '2'
				return withoutNDC.length is 8
			when '9'
				return withoutNDC.length is 8
			when '58'
				return withoutNDC.length is 7
			else
			# Should be updated based on link (1)
				return withoutNDC.length is 6 or withoutNDC.length is 7

	splitNumber: (number) =>
		switch number.length
			when 8
				splitNumber = number.split(/(\d{4})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1
			when 7
				splitNumber = number.split(/(\d{3})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1
			when 6
				splitNumber = number.split(/(\d{2})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1

		return [number]

window.vtex.phone.countries['56'] = new Chile()