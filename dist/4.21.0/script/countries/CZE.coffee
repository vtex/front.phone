
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class CzechRepublic
	constructor: ->
		@countryName = "Czech Republic"
		@countryNameAbbr = "CZE"
		@countryCode = '420'
		@regex = /^(\+?420)?(2[0-9]{2}|3[0-9]{2}|4[0-9]{2}|5[0-9]{2}|72[0-9]|73[0-9]|77[0-9]|60[1-8]|56[0-9]|70[2-5]|79[0-9])[0-9]{3}[0-9]{3}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["2","31","32","35","37","38","39","41","47","46","48","49","51","53","54","55","59","56","57","58","601","602","603","604","605","606","607","608","702","703","704","705","720","730","731","732","733","734","735","736","738","739","770","771","772","773","774","775","776","778","779","790","791","792","793","794","797","799"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)
		
		switch withoutNDC.length
			when 8
				if ndc is '2' then return phone
			when 7
				if ndc.length is 2 then return phone
			when 6
				if ndc.length is 3 and ndc[0] is '6' or ndc[0] is '7'
					phone.isMobile = true
					return phone

	splitNumber: (number) =>
		if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)

		return [number]

# register
czechrepublic = new CzechRepublic()
Phone.countries['420'] = czechrepublic

# exports
module.exports = czechrepublic