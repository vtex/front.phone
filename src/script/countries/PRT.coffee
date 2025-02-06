
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.itu.int/oth/T02020000A9/en
class Portugal
	constructor: ->
		@countryName = "Portugal"
		@countryNameAbbr = "PRT"
		@countryCode = '351'
		@regex = /^(?:(?:\+|)351|)(?:[2,9]\d{8})$/
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['21', '22', '231', '232', '233', '234', '235', '236', '238', '239', '241', '242', '243', '244', '245', '249', '251', '252', '253', '254', '255', '256', '258', '259', '261', '262', '263', '265', '266', '268', '269', '271', '272', '273', '274', '275', '276', '277', '278', '279', '281', '282', '283', '284', '285', '286', '289', '291', '292', '295', '296']
		@mobileNumbers = ['90', '91', '92', '93', '96']
		@ndcRegex = /^(?:351|0)?\s?(?:9[1236]\d{7}|2(?:1\d{7}|2\d{7}|3[1-689]\d{6}|4[459]\d{6}|5[1-689]\d{6}|6[1-35689]\d{6}|7[1-9]\d{6}|8[1-689]\d{6}|9[1256]\d{6}))$/

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
portugal = new Portugal()
Phone.countries['351'] = portugal

# exports
module.exports = portugal
