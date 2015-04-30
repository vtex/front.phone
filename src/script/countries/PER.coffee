
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://www.howtocallabroad.com/peru/
class Peru
	constructor: ->
		@countryName = "Peru"
		@countryNameAbbr = "PER"
		@countryCode = '51'
		@regex = /^(?:(?:\+|)51|)(?:0|)(?:(?:1\d{7})|(?:9\d{8})|(?:(?:4[1234]|5[12346]|6[1234567]|7[2346]|8[234])\d{6}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'1','9','41','42','43','44','51','52','53','54','56','61','62','63','64','65','66','67','72','73','74','76','82','83','84'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryCode, ndc, withoutNDC)
		if ndc is '1' and withoutNDC.length is 7			
			return phone
		else if ndc is '9' and withoutNDC.length is 8
			phone.isMobile = true			
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
			return phone
		else if ndc.length is 2 and withoutNDC.length is 6				
			return phone

	splitNumber: (number) =>
		if number.length is 6
			return Phone.compact number.split(/(\d{3})(\d{3})/)
		else if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else if number.length is 9
			return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)

		return [number]

# register
peru = new Peru()
Phone.countries['51'] = peru

# exports
module.exports = peru
