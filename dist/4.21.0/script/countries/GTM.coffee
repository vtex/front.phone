
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Guatemala
# http://www.howtocallabroad.com/guatemala/
class Guatemala
	constructor: ->
		@countryName = "Guatemala"
		@countryNameAbbr = "GTM"
		@countryCode = '502'
		@regex = /^(?:(?:\+|)502|)(?:[2-7]\d{7})$/
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['2', '6', '7', '3', '4', '5']
		@mobileNumbers = ['3', '4', '5']

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutCountryCode.length isnt 8
			return null
		if ndc and withoutNDC[0] in @mobileNumbers
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
				resultString = "+" + phone.countryCode + " "
				resultString += splitNumber.join(" ")

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
guatemala = new Guatemala()
Phone.countries['502'] = guatemala

# exports
module.exports = guatemala
