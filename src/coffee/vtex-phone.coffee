root = exports ? this

class PhoneNumber
	constructor: (countryCode, nationalDestinationCode, number, originalNumber) ->
		@countryCode = countryCode
		@nationalDestinationCode = nationalDestinationCode
		@number = number
		@originalNumber = originalNumber
		@isMobile = false

		# Argentina madness only
		@has15 = false

	valid: (isValid) =>
		@valid = isValid

class Phone
	constructor: ->
		# Like so: +55 (21) 9898-6565
		@INTERNATIONAL = 0

		# Like so: (21) 9898-6565
		@NATIONAL = 1

		# And: 9898-6565
		@LOCAL = 2


	validateInternational: (originalNumber) =>
		number = originalNumber

		# Clean up number
		number = @normalize(number)

		for countryCode, countryObj of vtex.phone.countries
			countryCodeRegex = new RegExp "^"+countryCode

			if countryCodeRegex.test(number)
				withoutCountryCode = number.replace(countryCodeRegex, "")
				foundCountryCode = true
				break

		if foundCountryCode
			for nationalDestinationCode in countryObj.nationalDestinationCode
				ndcPattern = "^("+countryObj.optionalTrunkPrefix+"|)"+nationalDestinationCode
				ndcRegex = new RegExp ndcPattern

				if ndcRegex.test(withoutCountryCode)
					withoutNDC = withoutCountryCode.replace(ndcRegex, "")
					foundNationalDestinationCode = true
					break

		if foundNationalDestinationCode
			phoneNumber = countryObj.specialRules(originalNumber, withoutCountryCode,
												withoutNDC, nationalDestinationCode)

			if phoneNumber
				phoneNumber.valid(true)
				return phoneNumber

		return null

	normalize: (number) =>
		# Remove whitespaces, parenthesis, slashes, dots, plus sign and letters
		return number.replace(/\ |\(|\)|\-|\.|[A-z]|\+/g, "")

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
			else
				resultString = ""

		return resultString

# exports
root.vtex = root.vtex || {}
root.vtex.phone = new Phone()
root.vtex.phone.PhoneNumber = PhoneNumber
