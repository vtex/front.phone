


Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Venezuela
# https://es.wikipedia.org/wiki/Anexo:Prefijos_telef%C3%B3nicos_de_Venezuela
class Venezuela
	constructor: ->
		@countryName = "Venezuela"
		@countryNameAbbr = "VEN"
		@countryCode = '58'
		@regex = /^(?:(?:\+|)58|)(?:0|)(?:(?:(?:2(?:12|3[45789]|4[0-9]|5[1-9]|6[0-9]|7[0-9]|8[1-9]|9[1-5])|(?:4(?:1[24-8]|2[46])))\d{7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["212","234","235","237","238","239","240","241","242","243","244","245","246","247","248","249","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271","272","273","274","275","276","277","278","279","281","282","283","284","285","286","287","288","289","291","292","293","294","295","412","414","415","416","417","418","424","426"]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 7
			phone.isMobile = ndc[0] is '4'
			return phone

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)

		return [number]

# register
venezuela = new Venezuela()
Phone.countries['58'] = venezuela

# exports
module.exports = venezuela
