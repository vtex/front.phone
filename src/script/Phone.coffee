
class Phone
	constructor: ->
		# Like so: +55 21 9898 6565
		@INTERNATIONAL = 0

		# Like so: (21) 9898-6565
		@NATIONAL = 1

		# And: 9898-6565
		@LOCAL = 2

		@countries = {}

	getPhoneNational: (nationalNumber, givenCountryCode, givenNationalDestinationCode) =>
		return null if nationalNumber is null
		nationalNumber = @normalize(nationalNumber) # Clean up number

		countryObj = @countries[givenCountryCode]
		if not countryObj then return null

		if givenNationalDestinationCode
			nationalDestinationCode = givenNationalDestinationCode
			[foundNDC, ndcRegex] = @testNDC(nationalDestinationCode, countryObj, nationalNumber)
		else
			for nationalDestinationCode in countryObj.nationalDestinationCode
				[foundNDC, ndcRegex] = @testNDC(nationalDestinationCode, countryObj, nationalNumber)
				break if foundNDC is true

		if not foundNDC and countryObj.nationalDestinationCode.length > 0 then return null

		withoutNDC = nationalNumber.replace(ndcRegex, "")

		phoneNumber = countryObj.specialRules(nationalNumber, withoutNDC, nationalDestinationCode)

		if phoneNumber
			phoneNumber.valid(true)
			return phoneNumber
		else
			return null

	getPhoneInternational: (number, givenCountryCode, givenNationalDestinationCode) =>
		return null if number is null
		number = @normalize(number) # Clean up number

		if givenCountryCode
			countryCode = givenCountryCode
			[foundCountryCode, countryCodeRegex] = @testCountryCode(countryCode, number)
		else
			for countryCode, countryObj of @countries
				[foundCountryCode, countryCodeRegex] = @testCountryCode(countryCode, number)
				break if foundCountryCode is true

		if not foundCountryCode then return null

		withoutCountryCode = number.replace(countryCodeRegex, "")
		return @getPhoneNational(withoutCountryCode, countryCode, givenNationalDestinationCode)

	normalize: (number) =>
		# Remove whitespaces, parenthesis, slashes, dots, plus sign and letters
		return number.replace(/\ |\(|\)|\-|\.|[A-z]|\+/g, "")

	compact: (array) =>
		newArray = []
		for element in array
			newArray.push element if element isnt ""
		return newArray

	validate: (number, givenCountryCode) =>
		return false if number is null
		number = @normalize(number)

		if givenCountryCode
			return @countries[givenCountryCode].regex.test(number)
		else
			for countryCode, countryObj of @countries
				return true if countryObj.regex.test(number)
			return false

	testCountryCode: (countryCode, number) =>
		countryCodeRegex = new RegExp "^"+countryCode

		if countryCodeRegex.test(number) then [true, countryCodeRegex] else [false, null]

	testNDC: (nationalDestinationCode, countryObj, number) =>
		ndcPattern = "^("+countryObj.optionalTrunkPrefix+"|)"+nationalDestinationCode
		ndcRegex = new RegExp ndcPattern

		if ndcRegex.test(number) then [true, ndcRegex] else [false, null]

	format: (phone, format = @INTERNATIONAL) =>
		return null if phone is null

		if @countries[phone.countryCode].format
			return @countries[phone.countryCode].format(phone, format)

		resultString = ""

		splitNumber = @countries[phone.countryCode].splitNumber(phone.number)

		switch format
			when @INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				if phone.nationalDestinationCode
					resultString += phone.nationalDestinationCode + " "
				resultString += splitNumber.join(" ")

			when @NATIONAL
				if phone.nationalDestinationCode
					resultString += "(" + phone.nationalDestinationCode + ") "
				separator = @countries[phone.countryCode].nationalNumberSeparator
				resultString += splitNumber.join(separator)

			when @LOCAL
				separator = @countries[phone.countryCode].nationalNumberSeparator
				resultString = splitNumber.join(separator)

		return resultString

	getCountryCodeByName: (name) =>
		for key, value of @countries
			if value.countryName is name
				return value.countryCode

	getCountryCodeByNameAbbr: (nameAbbr) =>
		for key, value of @countries
			if value.countryNameAbbr.constructor is Array
				for abbr in value.countryNameAbbr
					if abbr is nameAbbr
						return value.countryCode
			else
				if value.countryNameAbbr is nameAbbr
					return value.countryCode

# exports
module.exports = new Phone()
