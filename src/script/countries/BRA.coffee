
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://en.wikipedia.org/wiki/Local_conventions_for_writing_telephone_numbers#Brazil
class Brazil
	constructor: ->
		@countryName = "Brazil"
		@countryNameAbbr = "BRA"
		@countryCode = '55'
		@regex = /^(?:(?:(?:\+|)(?:55|)|))(?:0|)(?:(?:(?:1[1-9]|2[12478]|3[1-8]|6[1-9]|7[134579]|8[1-9]|9[1-9]|4[1-9]|5[1-5])(?:9\d{8}|\d{8})))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = '-'
		@nationalDestinationCode =
			[
				'11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '27', '28', '31', '32', '33', '34', '35', '36', '37', '38', '41', '42', '43', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '61', '62', '63', '64', '65', '66', '67', '68', '69', '71', '72', '73', '74', '75', '77', '78', '79', '81', '82', '83', '84', '85', '86', '87', '88', '89', '91', '92', '93', '94', '95', '96', '97', '98', '99'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		# Needs to be updated in 2015 (as in link (1) above)
		noNineDigitsNDC = ['41', '42', '43', '44', '45', '46', '47', '48', '49', '51', '53', '54', '55']
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 9 and withoutNDC.indexOf("9") is 0
			phone.isMobile = true
			return phone
		else
			if withoutNDC.length is 8 then return phone

	splitNumber: (number) =>
		if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)
		else if number.length is 9 and number.indexOf("9") is 0
			return Phone.compact number.split(/(\d{5})(\d{4})/)

		return [number]

# register
brazil = new Brazil()
Phone.countries['55'] = brazil

# exports
module.exports = brazil
