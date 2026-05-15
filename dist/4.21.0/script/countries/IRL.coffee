
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Ireland
	constructor: ->
		@countryName = "Ireland"
		@countryNameAbbr = "IRL"
		@countryCode = '353'
		@regex = /^(?:(?:\+|)353|)(?:0|)(?:1|2[1-9]|4(?:0[24]|[1-79])|5(?:0[45]|[1-36-9])|6[1-9]|7(?:1|4)|8(?:[35679])|9(?:[013-9]))(?:\d{5,7})$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = [
			'1', '21', '22', '23', '24', '25', '26', '27', '28', '29', '402', '404', '41', '42', '43', '44', '45', '46', '47', '49', '504', '505', '51', '52', '53', '56', '57', '58', '59', '61', '62', '63', '64', '65', '66', '67', '68', '69', '71', '74', '83', '85', '86', '87', '89', '90', '91', '93', '94', '95', '96', '97', '98', '99'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if ndc[0] is '8'
			phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
		else
			phone.isMobile = false

		return phone

	format: (phone, format) =>
		resultString = ""

		fullNumber = phone.nationalDestinationCode + phone.number
		splitNumber = @splitNumber(fullNumber)

		switch format
			when Phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + @nationalNumberSeparator
				resultString += splitNumber.join(@nationalNumberSeparator)

			else
				resultString += splitNumber.join(@nationalNumberSeparator)

		return resultString

	splitNumber: (number) =>
		
		switch true
			when number[0] is '8'
				return Phone.compact number.split(/(\d{2})(\d{3})(\d{4})/)
			when number[0] is '1'
				return Phone.compact number.split(/(\d{1})(\d{3})(\d{4})/)
			when number[0..2] in ['402','404','504','505'] and number.length is 8
				return Phone.compact number.split(/(\d{3})(\d{5})/)
			when number[0] not in ['1','8'] and number.length is 9
				return Phone.compact number.split(/(\d{2})(\d{3})(\d{4})/)
			when number[0] not in ['1','8'] and number.length is 8
				return Phone.compact number.split(/(\d{2})(\d{3})(\d{3})/)
			when number[0] not in ['1','8'] and number.length is 7
				return Phone.compact number.split(/(\d{2})(\d{5})/)

		return [number]

# register
ireland = new Ireland()
Phone.countries['353'] = ireland

# exports
module.exports = ireland
