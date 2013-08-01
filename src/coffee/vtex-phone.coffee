window.vtex = window.vtex || {}

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
				for nationalDestinationCode in countryObj.nationalDestinationCode
					ndcRegex = "^("+countryObj.initialOptionalDigit+"|)"+nationalDestinationCode
					ndcPattern = new RegExp ndcRegex
					withoutNDC = withoutCountryCode.replace(ndcPattern, "")

					if withoutNDC.length < withoutCountryCode.length
						result = countryObj.specialRules(originalNumber, withoutCountryCode,
														withoutNDC, nationalDestinationCode)
						if result
							return {
								nationalDestinationCode: nationalDestinationCode,
								countryCode: countryCode,
								number: withoutNDC,
								originalNumber: originalNumber,
								valid: true
							}
						else
							return {
								nationalDestinationCode: nationalDestinationCode,
								countryCode: countryCode,
								number: withoutNDC,
								originalNumber: originalNumber,
								valid: false
							}

		return null		

window.vtex.phone = new Phone()
