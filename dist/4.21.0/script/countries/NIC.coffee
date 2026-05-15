
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')


class Nicaragua
	constructor: ->
		@countryName = "Nicaragua"
		@countryNameAbbr = "NIC"
		@countryCode = '505'
		@regex = /^(?:(?:\+|)505|)(?:[2578]\d{7})$/
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['2', '5', '7', '8']
		@mobileNumbers = ['5', '7', '8']

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutCountryCode.length isnt 8
			return null
		if ndc[0] in @mobileNumbers
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
				separator = @nationalNumberSeparator
				resultString = "+" + phone.countryCode + separator
				resultString += splitNumber.join(separator)

			else
				separator = @nationalNumberSeparator
				resultString += splitNumber.join(separator)

		return resultString

	splitNumber: (number) =>
		switch number.length
			when 8
				return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]

# register
nicaragua = new Nicaragua()
Phone.countries['505'] = nicaragua

# exports
module.exports = nicaragua
