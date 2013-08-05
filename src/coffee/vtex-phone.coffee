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
			countryCodePattern = new RegExp "^"+countryCode
			withoutCountryCode = number.replace(countryCodePattern, "")

			if withoutCountryCode.length < number.length
				foundCountryCode = true
				break

		if foundCountryCode
			for nationalDestinationCode in countryObj.nationalDestinationCode
				ndcRegex = "^("+countryObj.nationalTrunkPrefix+"|)"+nationalDestinationCode
				ndcPattern = new RegExp ndcRegex
				withoutNDC = withoutCountryCode.replace(ndcPattern, "")

				if withoutNDC.length < withoutCountryCode.length
					foundNationalDestinationCode = true
					break

		if foundNationalDestinationCode
			result = countryObj.specialRules(originalNumber, withoutCountryCode,
												withoutNDC, nationalDestinationCode)

			phoneNumber = new PhoneNumber(countryCode, nationalDestinationCode, withoutNDC, originalNumber)
			if result
				phoneNumber.valid(true)
				return phoneNumber
			else
				phoneNumber.valid(false)
				return phoneNumber

		return null

	normalize: (number) =>
		# Remove whitespaces, parenthesis, slashes, dots, plus sign and letters
		return number.replace(/\ |\(|\)|\-|\.|[A-z]|\+/g, "")

	format: (phone, format = vtex.phone.INTERNATIONAL) =>
		return vtex.phone.countries[phone.countryCode].format(phone, format)


window.vtex.phone = new Phone()
