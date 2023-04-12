
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Australia
	constructor: ->
		@countryName = "Australia"
		@countryNameAbbr = "AUS"
		@countryCode = '61'
		@regex = /^(?:(?:(?:\+|)(?:61|)(?:0|)|))([1-5,7-8])[0-9]{8,9}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["1","2","3","4","5","7","8"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutCountryCode[0] in ['4', '5']
			phone.isMobile = true
			return phone
		else return phone

	# splitNumber: (number) =>
	# 	return Phone.compact number.split(/(\d{1})(\d{4})(\d{4})/)

	# 	return [number]

	format: (phone, format = Phone.NATIONAL) =>
		resultString = ""
		fullNumber = phone.nationalDestinationCode + phone.number
		separator = @nationalNumberSeparator

		switch format
			when Phone.NATIONAL, Phone.LOCAL
				if phone.nationalDestinationCode is '4'||'5'
					console.log("ENTROU NA FORMATAÇÃO DA CAMILA")
					resultString += '0'+ phone.nationalDestinationCode
					# return resultString	+ Phone.compact phone.number.split(/(\d{2})(\d{3})(\d{3})/)
					# return resultString + @splitNumber(phone.number).join(separator)
				else
				#  phone.nationalDestinationCode
					console.log("ENTROU NA FORMATAÇÃO ORIGINAL")
					resultString += '(0' + phone.nationalDestinationCode + ') '
				return resultString + @splitNumber(phone.number).join(separator)
			else
				console.log("ENTROU NA FORMATAÇÃO FINAL")
				return "+" + phone.countryCode + " " + phone.nationalDestinationCode + " " + phone.number

	splitNumber: (number) =>
		switch number.length
			when 11 
				console.log("ENTROU NO 11")
				return Phone.compact number.split(/(\d{2})(\d{3})(\d{3})(\d{3})/)
			when 10 
				console.log("ENTROU NO 10")
				return Phone.compact number.split(/(\d{2})(\d{4})(\d{4})/)
			when 9 
				console.log("ENTROU NO 9")
				return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)
			when 8
				console.log("ENTROU NO 8")
				return Phone.compact number.split(/(\d{4})(\d{4})/)

		return [number]	

# register
australia = new Australia()
Phone.countries['61'] = australia

# exports
module.exports = australia
