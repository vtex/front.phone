
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.itu.int/oth/T0202000006/en
class Angola
	constructor: ->
		@countryName = "Angola"
		@countryNameAbbr = "AGO"
		@countryCode = '244'
		@regex = /^(?:(?:\+|)244|)(?:[2-79]\d{8})$/
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['2', '31', '33', '34', '35', '36', '41', '48', '49', '51', '52', '53', '54', '61', '64', '65', '72', '91', '92']
		@mobileNumbers = ['91', '923', '93']
		@ndcRegex = /^(?:244|)(?:2|(3[13-6])|(4[189])|(5[1-4])|(6[145])|72|(9[1-2]))[0-9]{8}$/

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
