
class PhoneNumber
	constructor: (countryCode, nationalDestinationCode, number) ->
		@countryCode = countryCode
		@nationalDestinationCode = nationalDestinationCode
		@number = number
		@isMobile = null

	valid: (isValid) =>
		@valid = isValid

module.exports = PhoneNumber