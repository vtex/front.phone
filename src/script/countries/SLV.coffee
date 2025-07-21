
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class ElSalvador
	constructor: ->
		@countryName = "El Salvador"
		@countryNameAbbr = "SLV"
		@countryCode = '503'
		@regex = /^(\+?503)?[267]([0-9]{7})$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["2","6","7"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		
		if withoutNDC.length is 8
            if ndc[0] is '2'
                if ndc[0] is '6' or ndc[0] is '7'
                    phone.isMobile = true
            return phone

	splitNumber: (number) =>
		if number.length is 11
			return Phone.compact number.split(/(\d{3})(\d{4})(\d{4})/)
        if number.length is 8
			return Phone.compact number.split(/(\d{4})(\d{4})/)
		return [number]

# register
elsalvador = new ElSalvador()
Phone.countries['503'] = elsalvador

# exports
module.exports = elsalvador