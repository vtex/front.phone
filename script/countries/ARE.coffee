
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class UnitedArabEmirates
	constructor: ->
		@countryName = "United Arab Emirates"
		@countryNameAbbr = "ARE"
		@countryCode = '971'
		@regex = /^(?:\+|)(?:971|)(?:0|)*\d{9,10}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['01', '02', '03', '04', '06', '07', '09', '050', '052', '054', '055', '056', '058']
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if ndc.length is 3 or ndc[0] is '5'
			phone.isMobile = true
			return phone	

	splitNumber: (number) =>
		if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)
		else if number.length is 10
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{4})/)

		return [number]

# register
unitedarabemirates = new UnitedArabEmirates()
Phone.countries['971'] = unitedarabemirates

# exports
module.exports = unitedarabemirates
