root = exports ? this

class PhoneNumber
	constructor: (countryCode, nationalDestinationCode, number) ->
		@countryCode = countryCode
		@nationalDestinationCode = nationalDestinationCode
		@number = number
		@isMobile = null

		# Argentina madness only
		@has15 = null

	valid: (isValid) =>
		@valid = isValid

class Phone
	constructor: ->
		# Like so: +55 21 9898 6565
		@INTERNATIONAL = 0

		# Like so: (21) 9898-6565
		@NATIONAL = 1

		# And: 9898-6565
		@LOCAL = 2

	getPhoneNational: (nationalNumber, givenCountryCode, givenNationalDestinationCode) =>
		return null if nationalNumber is null
		nationalNumber = @normalize(nationalNumber) # Clean up number

		countryObj = root.vtex.phone.countries[givenCountryCode]
		if not countryObj then return null

		if givenNationalDestinationCode
			nationalDestinationCode = givenNationalDestinationCode
			[foundNDC, ndcRegex] = @testNDC(nationalDestinationCode, countryObj, nationalNumber)
		else
			for nationalDestinationCode in countryObj.nationalDestinationCode
				[foundNDC, ndcRegex] = @testNDC(nationalDestinationCode, countryObj, nationalNumber)
				break if foundNDC is true

		if not foundNDC then return null

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
			for countryCode, countryObj of vtex.phone.countries
				[foundCountryCode, countryCodeRegex] = @testCountryCode(countryCode, number)
				break if foundCountryCode is true

		if not foundCountryCode then return null

		withoutCountryCode = number.replace(countryCodeRegex, "")
		return @getPhoneNational(withoutCountryCode, countryCode, givenNationalDestinationCode)

	normalize: (number) =>
		# Remove whitespaces, parenthesis, slashes, dots, plus sign and letters
		return number.replace(/\ |\(|\)|\-|\.|[A-z]|\+/g, "")

	validate: (number, givenCountryCode) =>
		number = @normalize(number)

		if givenCountryCode
			return vtex.phone.countries[givenCountryCode].regex.test(number)
		else
			valid = false
			for countryCode, countryObj of vtex.phone.countries
				#console.log countryObj.regex.test(number)
				if countryObj.regex.test(number)
					valid = true
					break
			return valid

	testCountryCode: (countryCode, number) =>
		countryCodeRegex = new RegExp "^"+countryCode

		if countryCodeRegex.test(number) then [true, countryCodeRegex] else [false, null]

	testNDC: (nationalDestinationCode, countryObj, number) =>
		ndcPattern = "^("+countryObj.optionalTrunkPrefix+"|)"+nationalDestinationCode
		ndcRegex = new RegExp ndcPattern

		if ndcRegex.test(number) then [true, ndcRegex] else [false, null]

	format: (phone, format = vtex.phone.INTERNATIONAL) =>
		if vtex.phone.countries[phone.countryCode].format
			return vtex.phone.countries[phone.countryCode].format(phone, format)

		resultString = ""

		splitNumber = vtex.phone.countries[phone.countryCode].splitNumber(phone.number)

		switch format
			when vtex.phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				if phone.nationalDestinationCode
					resultString += phone.nationalDestinationCode + " "
				resultString += splitNumber.join(" ")

			when vtex.phone.NATIONAL
				if phone.nationalDestinationCode
					resultString += "(" + phone.nationalDestinationCode + ") "
				separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator
				resultString += splitNumber.join(separator)

			when vtex.phone.LOCAL
				separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator
				resultString = splitNumber.join(separator)

		return resultString

	getCountryCodeByName: (name) =>
		for key, value of vtex.phone.countries
			if value.countryName is name
				return value.countryCode

	getCountryCodeByNameAbbr: (nameAbbr) =>
		for key, value of vtex.phone.countries
			if value.countryNameAbbr is nameAbbr
				return value.countryCode

# exports
root.vtex = root.vtex || {}
root.vtex.phone = new Phone()
root.vtex.phone.PhoneNumber = PhoneNumber
