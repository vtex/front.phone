
class PhoneNumber
	constructor: (countryNameAbbr, countryCode, nationalDestinationCode, number) ->
		@countryNameAbbr = countryNameAbbr
		@countryCode = countryCode
		@nationalDestinationCode = nationalDestinationCode
		@number = number
		@isMobile = null

	valid: (isValid) =>
		@valid = isValid

module.exports = PhoneNumber
