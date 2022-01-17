
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Iraq
	constructor: ->
		@countryName = "Iraq"
		@countryNameAbbr = "IRQ"
		@countryCode = '964'
		@regex = /^(?:\+|00)964(7?\d{1,2})\d{7}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			['7(\\d{2})', '1', '21', '23', '24', '25', '30', '32', '33', '36', '37', '40', '42', '43', '50', '53', '60', '62', '66']
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 7
			phone.isMobile = ndc[0] is '7'
			return phone
		else if withoutNDC.length is 7 or withoutNDC.length is 6 then return phone

# register
iraq = new Iraq()
Phone.countries['964'] = iraq

# exports
module.exports = iraq
