
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://www.copaco.com.py/portal/index.php/atencion-al-cliente/8-empresa/74-codigos-de-area.html
# http://en.wikipedia.org/wiki/Telephone_numbers_in_Paraguay
class Paraguay
	constructor: ->
		@countryName = "Paraguay"
		@countryNameAbbr = "PRY"
		@countryCode = '595'
		@regex = /^(?:(?:\+|)595|)(?:0|)(?:(?:21|3[289]|4[14-8]|61|7[123]|8[13]|2(?:2[04568]|7[15]|9[1-5])|3(?:18|3[0167]|4[2357]|5[01]|60|70)|4(?:18|2[045]|3[12]|5[13]|64|71|9[1-47])|5(?:1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[02-4]|7[0-3]|80)|6(?:3[1-3]|44|60|7[1-46-8])|7(?:17|4[0-4]|50|6[2-578]|7[05]|8[0-8]|90)|858|9(?:[6-9][0-9]))(?:\d{6,7}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'21', '32', '38', '39', '41', '44', '46', '47', '48', '61', '71', '72', '73', '81', '83', '220', '224', '225', '226', '228', '271', '275', '291', '292', '293', '294', '295', '318', '330', '331', '336', '337', '342', '343', '345', '347', '350', '351', '360', '370', '418', '420', '424', '425', '431', '432', '451', '453', '464', '471', '491', '492', '493', '494', '497', '510', '511', '512', '513', '514', '515', '516', '517', '518', '519', '520', '521', '522', '523', '524', '525', '526', '527', '528', '529', '530', '531', '532', '533', '534', '535', '536', '537', '538', '539', '540', '541', '542', '543', '544', '545', '546', '547', '548', '549', '550', '552', '553', '554', '570', '571', '572', '573', '580', '631', '632', '633', '644', '660', '671', '672', '673', '674', '676', '677', '678', '717', '740', '741', '742', '743', '744', '750', '762', '763', '764', '765', '767', '768', '770', '775', '780', '781', '782', '783', '784', '785', '786', '787', '788', '790', '858', '960', '961', '962', '963', '964', '965', '966', '967', '968', '969', '970', '971', '972', '973', '974', '975', '976', '977', '978', '979', '980', '981', '982', '983', '984', '985', '986', '987', '988', '989', '990', '991', '992', '993', '994', '995', '996', '997', '998', '999'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if withoutNDC.length is 6 or withoutNDC.length is 7
			if ndc.length is 3 and ndc[0] is '9'
				phone.isMobile = true
			return phone

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)
		else
			return Phone.compact number.split(/(\d{3})(\d{3})/)

	format: (phone, format) =>
		resultString = ""

		splitNumber = @splitNumber(phone.number)

		switch format
			when Phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				resultString += phone.nationalDestinationCode + " "
				resultString += splitNumber.join(" ")
			else
				resultString += phone.nationalDestinationCode + " "
				resultString += splitNumber.join(" ")

		return resultString

# register
paraguay = new Paraguay()
Phone.countries['595'] = paraguay

# exports
module.exports = paraguay
