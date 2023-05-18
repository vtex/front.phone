
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.itu.int/oth/T020200005F/en
class Honduras
	constructor: ->
		@countryName = "Honduras"
		@countryNameAbbr = "HND"
		@countryCode = '504'
		@regex = /^(?:(?:\+|)504|)(?:[2-3,7-9]\d{7})$/
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['200', '201', '209', '211', '212', '213', '216', '220', '221', '222', '223', '224', '225', '226', '227', '228', '229', '230', '231', '231', '232', '233', '234', '235', '236', '237', '238', '239', '240', '245', '246', '255', '257', '290', '291', '423', '424', '425', '429', '431', '433', '434', '435', '436', '438', '439', '440', '441', '442', '443', '444', '445', '446', '448', '451', '452', '453', '455', '543', '544', '545', '550', '551', '552', '553', '554', '555', '556', '557', '558', '559', '565', '566', '574', '640', '641', '642', '643', '647', '648', '650', '651', '652', '653', '654', '655', '656', '657', '658', '659', '660', '661', '662', '663', '664', '665', '667', '668', '669', '670', '671', '672', '673', '674', '675', '678', '680', '681', '682', '683', '684', '685', '686', '687', '688', '690', '691', '764', '766', '767', '768', '769', '770', '772', '773', '774', '775', '776', '777', '778', '779', '783', '784', '879', '880', '881', '882', '883', '885', '887', '888', '889', '891', '892', '893', '894', '895', '897', '898', '899']
		@mobileNumbers = ['3', '7', '8', '9']
		@ndcRegex = /^(?:504|)(?:[2-9]{1}|)555(?:[0-9]{4})$/

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		
		console.log({ndc, withoutNDC, withoutCountryCode, ini: withoutCountryCode[0] })
		if withoutCountryCode.length isnt 8
			return null
		if withoutCountryCode[0] in @mobileNumbers
			phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
		else
			phone.isMobile = false

		console.log({phone})
		
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
honduras = new Honduras()
Phone.countries['504'] = honduras

# exports
module.exports = honduras
