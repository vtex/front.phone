
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class SaudiArabia
	constructor: ->
		@countryName = "Saudi Arabia"
		@countryNameAbbr = "KSA"
		@countryCode = '966'
		@regex = /^(?:\+|)(?:966|)(?:0|)*\d{9,10}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode = ['011', '012', '013', '014', '016', '017', '0811', '050', '053', '055', '051', '058', '059', '054', '056', '0570', '0571', '0572', '0575', '0576', '0577', '0578']
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 6
			phone.isMobile = true
			return phone	

	splitNumber: (number) =>
		if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)
		else if number.length is 10
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{4})/)

		return [number]

# register
saudiarabia = new SaudiArabia()
Phone.countries['966'] = saudiarabia

# exports
module.exports = saudiarabia
