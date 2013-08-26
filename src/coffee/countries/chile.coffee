root = exports ? this

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/chile/
# (1) http://www.cambionumeracion.cl/?page_id=4
class Chile
	constructor: ->
		@countryName = "Chile"
		@countryNameAbbr = "CHL"
		@countryCode = '56'
		@regex = /^(?:(?:\+|)56|)(?:0|)(?:(?:(?:2|9)\d{8})|(?:58\d{7})|(?:(?:3[2345]|4[1235]|5[123578]|6[134578]|7[1235])\d{6,7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'2','32','33','34','35','41','42','43','45','51','52','53','55','57','58','61','63','64','65','67','68','71','72','73','75', '9' # 9 is mobile
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new vtex.phone.PhoneNumber(@countryCode, ndc, withoutNDC)
		switch ndc
			when '2'
				if withoutNDC.length is 8 then return phone
			when '9'
				if withoutNDC.length is 8
					phone.isMobile = true
					phone.nationalDestinationCode = ''
					phone.number = withoutCountryCode
					return phone
			when '58'
				if withoutNDC.length is 7 then return phone
			else
			# Should be updated based on link (1)
				if withoutNDC.length is 6 or withoutNDC.length is 7 then return phone

	splitNumber: (number) =>
		switch number.length
			when 9
				return _.compact number.split(/(\d{1})(\d{4})(\d{4})/)
			when 8
				return _.compact number.split(/(\d{4})(\d{4})/)
			when 7
				return _.compact number.split(/(\d{3})(\d{4})/)
			when 6
				return _.compact number.split(/(\d{2})(\d{4})/)

		return [number]

# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['56'] = new Chile()