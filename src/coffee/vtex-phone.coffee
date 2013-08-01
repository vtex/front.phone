window.vtex = window.vtex || {}

class PhoneNumber
	constructor: (countryCode, nationalDestinationCode, number, originalNumber) ->
		@countryCode = countryCode
		@nationalDestinationCode = nationalDestinationCode
		@number = number
		@originalNumber = originalNumber

	valid: (isValid) =>
		@valid = isValid

class Phone
	constructor: ->

	validateInternational: (originalNumber) =>
		number = originalNumber

		# Remove whitespaces, parenthesis, slashes and dots
		number = number.replace(/\ |\(|\)|\-|\./g, "")

		# Remove + sign
		number = if number.indexOf('+') is 0 then number.slice(1) else number

		for countryCode, countryObj of vtex.phone.countries
			countryCodePattern = new RegExp "^"+countryCode
			withoutCountryCode = number.replace(countryCodePattern, "")

			if withoutCountryCode.length < number.length
				foundCountryCode = true
				break

		if foundCountryCode
			for nationalDestinationCode in countryObj.nationalDestinationCode
				ndcRegex = "^("+countryObj.initialOptionalDigit+"|)"+nationalDestinationCode
				ndcPattern = new RegExp ndcRegex
				withoutNDC = withoutCountryCode.replace(ndcPattern, "")

				if withoutNDC.length < withoutCountryCode.length
					foundNationalDestinationCode = true
					break

		if foundNationalDestinationCode
			result = countryObj.specialRules(originalNumber, withoutCountryCode,
												withoutNDC, nationalDestinationCode)

			phoneNumber = new PhoneNumber(countryCode, nationalDestinationCode, number, originalNumber)
			if result
				phoneNumber.valid(true)
				return phoneNumber
			else
				phoneNumber.valid(false)
				return phoneNumber

		return null

window.vtex.phone = new Phone()
