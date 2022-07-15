
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Slovakia
	constructor: ->
		@countryName = "Slovakia"
		@countryNameAbbr = "SVK"
		@countryCode = '421'
		@regex = /^(?:(?:\+|)421|)(?:0|)\d{9}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["2","31","32","33","34","35","36","37","38","41","42","43","44","45","46","47","48","51","52","53","54","55","56","57","58","901","902","903","904","905","906","907","908","909","910","911","912","913","914","915","916","917","918","919","920","921","922","923","924","925","926","927","928","929","930","931","932","933","934","935","936","937","938","939","940","941","942","943","944","945","946","947","948","949","950","951","952","953","954","955","956","957","958","959"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		switch withoutNDC.length
			when 8
				if ndc is '2' then return phone
			when 7
				if ndc.length is 2 then return phone
			when 6
				if ndc.length is 3 and ndc[0] is '9'
					phone.isMobile = true
					return phone

	splitNumber: (number) =>
		if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)

		return [number]

# register
slovakia = new Slovakia()
Phone.countries['421'] = slovakia

# exports
module.exports = slovakia
