
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.itu.int/oth/T0202000006/en
class Honduras
	constructor: ->
		@countryName = "Angola"
		@countryNameAbbr = "AGO"
		@countryCode = '244'
		@regex = /^(?:(?:\+|)244|)(?:[2-7,9]\d{7})$/
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['2', '31', '33', '34', '35', '36', '41', '48', '49', '51', '52', '53', '54', '61', '64', '65', '65', '72', '91', '92']
		@mobileNumbers = ['91', '923', '93']
		# @ndcRegex = /^(?:244|)(?:[2-7,9]{1}|)(?:(20[0-1,9])|(21[1-3,6])|(22\d|23\d|24[0,5-6])|(25[57])|(29[01])|(42[3-5,9])|(43[1,3-6,8-9])|(44[0-6,8])|(45[1-3,5])|(54[3-5])|(55[0-9])|(565|566)|(574)|(64[0-3,7-8])|(65[0-9])|(66[0-5,7-9])|(67[0-5,8])|(68\d|69[01])|(76[4,6-9])|(77[0,2-9])|(783|784)|(879|88[0-3,5,7-9])|(89[1-5,7-9]))(?:[0-9]{4})$/

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutCountryCode)
		
		if withoutCountryCode.length isnt 9
			return null
		if withoutCountryCode[0] in @mobileNumbers
			phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
		else
			phone.isMobile = false
		return phone

	format: (phone, format) =>
		resultString = ""
		splitNumber = @splitNumber(phone.number)

		switch format
			when Phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				resultString += splitNumber.join(" ")

			else
				separator = @nationalNumberSeparator
				resultString += splitNumber.join(separator)

		return resultString
	splitNumber: (number) =>
		switch number.length
			when 9
				return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)

		return [number]

# register
angola = new Angola()
Phone.countries['244'] = angola

# exports
module.exports = angola
