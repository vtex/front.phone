root = exports ? this

# For more info check:
# http://www.aa-asterisk.org.uk/index.php/Regular_Expressions_for_Validating_and_Formatting_GB_Telephone_Numbers#Formatting_GB_telephone_numbers

class UnitedKingdom
	constructor: ->
		@countryName = "United Kingdom"
		@countryNameAbbr = "GBR"
		@countryCode = '44'
		@regex = /^\(?(?:(?:0(?:0|11)\)?[\s-]?\(?|)44\)?[\s-]?\(?(?:0\)?[\s-]?\(?)?|0)(?:\d{2}\)?[\s-]?\d{4}[\s-]?\d{4}|\d{3}\)?[\s-]?\d{3}[\s-]?\d{3,4}|\d{4}\)?[\s-]?(?:\d{5}|\d{3}[\s-]?\d{3})|\d{5}\)?[\s-]?\d{4,5}|8(?:00[\s-]?11[\s-]?11|45[\s-]?46[\s-]?4\d))(?:(?:[\s-]?(?:x|ext\.?\s?|\#)\d+)?)$/
		@mobileRegex = /^7(?:[1-4]\d\d|5(?:0[0-8]|[13-9]\d|2[0-35-9])|624|7(?:0[1-9]|[1-7]\d|8[02-9]|9[0-689])|8(?:[014-9]\d|[23][0-8])|9(?:[04-9]\d|1[02-9]|2[0-35-9]|3[0-689]))\d{6}$/
		@splitRegexs =
			[{
				#Ranges 2d, 55, 56, 70, 76 (excluding 7624) with 10 digits
				validLengths: [10]
				leadingDigits: /^(?:2|5[56]|7(?:0|6(?:[013-9]|2[0-35-9])))/,
				pattern: /^(\d{2})(\d{4})(\d{4})$/,
				format: "$1 $2 $3"
			},{
				#Ranges 11d, 1d1, 3dd, 9dd with 10 digits
				validLengths: [10]
				leadingDigits: /^(?:1(?:1|\d1)|3[0347]|9[018])/,
				pattern: /^(\d{3})(\d{3})(\d{4})$/,
				format: "$1 $2 $3"
			},{
				#Ranges 1dddd with 9 or 10 digits
				validLengths: [9, 10]
				leadingDigits: /^(?:1(?:3873|5(?:242|39[456])|697[347]|768[347]|9467))/,
				pattern: /^(\d{5})(\d{4,5})$/,
				format: "$1 $2"
			},{
				#Ranges 1ddd with 9 or 10 digits
				validLengths: [9, 10]
				leadingDigits: /^1/,
				pattern: /^(1\d{3})(\d{5,6})$/,
				format: "$1 $2"
			},{
				#Ranges 7ddd (including 7624) (not 70, 76) with 10 digits
				validLengths: [10]
				leadingDigits: /^7(?:[1-5789]|624)/,
				pattern: /^(7\d{3})(\d{6})$/,
				format: "$1 $2"
			},{
				#Ranges 800 1111 with 7 digits : UK ChildLine
				validLengths: [7]
				leadingDigits: /^8001111/,
				pattern: /^(800)(\d{4})$/,
				format: "$1 $2"
			},{
				#Ranges 845 46 47 with 7 digits : UK NHS Direct
				validLengths: [7]
				leadingDigits: /^84546\d/,
				pattern: /^(845)(46)(4\d)$/,
				format: "$1 $2 $3"
			},{
				#Ranges 84d, 87d with 10 digits
				validLengths: [10]
				leadingDigits: /^8(?:4[2-5]|7[0-3])/,
				pattern: /^(8\d{2})(\d{3})(\d{4})$/,
				format: "$1 $2 $3"
			},{
				#Ranges 80d (including 800) with 10 digits
				validLengths: [10]
				leadingDigits: /^80[08]/,
				pattern: /^(80\d)(\d{3})(\d{4})$/,
				format: "$1 $2 $3"
			},{
				#Ranges 500, 800 with 9 digits
				validLengths: [9]
				leadingDigits: /^[58]00/,
				pattern: /^([58]00)(\d{6})$/,
				format: "$1 $2"
			}]

		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '


		@nationalDestinationCode = [
				'20','23','24','28','29','113','114','115','116','117','118',
				'121','131','141','151','161','191','13873','15242','15394',
				'15395','15396','16973','16974','17683','17684','17687','19467',
				'16977'
		].concat (ndc for ndc in [12000..12999])
		

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new vtex.phone.PhoneNumber(@countryCode, ndc, withoutNDC)
		if withoutNDC.length is 10 and @mobileRegex.test(withoutNDC)
			phone.isMobile = true

		return phone

	splitNumber: (number) =>
		findSplitter = do ->
			(nmbr, splitRegexs) ->
				for potentialSplitGrp in splitRegexs
					if nmbr.length in potentialSplitGrp.validLengths and potentialSplitGrp.leadingDigits.test(nmbr)
						return potentialSplitGrp

		splitter = findSplitter(number, @splitRegexs)

		if splitter
			return vtex.phone.compact number.split(splitter.pattern)
		else  
			return [number]


# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['44'] = new UnitedKingdom()