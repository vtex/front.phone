
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# http://countrycode.org/usa
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Canada
# http://www.howtocallabroad.com/canada/
class NANP
	constructor: ->
		@countryName = "NANP"
		@countryNameAbbr = ["USA", "CAN", "ASM", "GUM", "MNP", "PRI", "VIR"]
		@countryCode = '1'
		@regex = /^(?:(?:(?:\+|)(?:1|))|)(?:1|)(?:2(?:0[1-9]|1[02-9]|2[4-9]|3[1469]|4[089]|5[01-46]|6[0279]|7[0468]|8[139])|3(?:0[1-9]|1[02-9]|2[01235]|3[014679]|4[01367]|5[12]|6[01459]|8[056])|4(?:0[1-9]|1[02-9]|2[345]|3[0-24578]|4[023578]|5[08]|6[49]|7[0589]|8[04]|50[1-57-9])|5(?:0[1-9]|1[02-9]|20|3[014]|4[01]|5[179]|6[1-47]|7[013-59]|8[01567])|6(?:0[1-9]|1[0234-9]|2[036-8]|3[0169]|4[167]|5[0179]|6[01279]|7[0189]|8[1249])|7(?:0[1-9]|1[2-9]|2[047]|3[01247]|4[07]|5[247]|6[02-59]|7[02-589]|8[01567])|8(?:0[1-8]|1[0-9]|28|3[0-25]|4[3578]|5[06-9]|6[02-57]|7[0238])|9(?:0[1-9]|1[02-9]|2[0578]|3[15-9]|4[0179]|5[124679]|7[0-3589]|8[045]|89))\d{7}$/
		@optionalTrunkPrefix = '1'
		@nationalNumberSeparator = ' '
		@usaNationalDestinationCode =
			[
				'201', '202', '203', '205', '206', '207', '208', '209', '209', '210', '212', '213', '214', '215', '216', '217', '218', '219', '224', '225', '227', '228', '229', '231', '234', '239', '240', '248', '251', '252', '253', '254', '256', '260', '262', '267', '269', '270', '274', '276', '278', '281', '283', '301', '302', '303', '304', '305', '307', '308', '309', '310', '312', '313', '314', '315', '316', '317', '318', '319', '320', '321', '323', '325', '330', '331', '334', '336', '337', '339', '341', '346', '347', '351', '352', '360', '361', '364', '369', '380', '385', '386', '401', '402', '404', '405', '406', '407', '408', '409', '410', '412', '413', '414', '415', '417', '419', '423', '424', '425', '430', '432', '434', '435', '440', '442', '443', '445', '447', '458', '464', '469', '470', '475', '478', '479', '480', '484', '501', '502', '503', '504', '505', '507', '508', '509', '510', '512', '513', '515', '516', '517', '518', '520', '530', '531', '534', '540', '541', '551', '557', '559', '561', '562', '563', '564', '567', '570', '571', '573', '574', '575', '580', '585', '586', '601', '602', '603', '605', '606', '607', '608', '609', '610', '612', '614', '615', '616', '617', '618', '619', '620', '623', '626', '627', '628', '630', '631', '636', '641', '646', '650', '651', '657', '659', '660', '661', '662', '667', '669', '678', '679', '681', '682', '689', '701', '702', '703', '704', '706', '707', '708', '712', '713', '714', '715', '716', '717', '718', '719', '720', '724', '727', '730', '731', '732', '734', '737', '740', '747', '752', '754', '757', '760', '762', '763', '764', '765', '769', '770', '772', '773', '774', '775', '779', '781', '785', '786', '801', '802', '803', '804', '805', '806', '808', '810', '812', '813', '814', '815', '816', '817', '818', '828', '830', '831', '832', '835', '843', '845', '847', '848', '850', '856', '857', '858', '859', '860', '862', '863', '864', '865', '870', '872', '878', '901', '903', '904', '906', '907', '908', '909', '910', '912', '913', '914', '915', '916', '917', '918', '919', '920', '925', '927', '928', '931', '935', '936', '937', '938', '940', '941', '947', '949', '951', '952', '954', '956', '957', '959', '970', '971', '972', '973', '975', '978', '979', '980', '984', '985', '989'
			]
		@canadaNationalDestinationCode =
			[
				'204', '226', '236', '249', '250', '289', '306', '343', '365', '403', '416', '418', '431', '437', '438', '450', '506', '514', '519', '579', '581', '587', '604', '613', '639', '647', '705', '709', '778', '780', '807', '819', '867', '873', '902', '905'
			]
		@asmNationalDestinationCode =
			[
				'684'
			]
		@gumNationalDestinationCode =
			[
				'671'
			]
		@mnpNationalDestinationCode =
			[
				'670'
			]
		@priNationalDestinationCode =
			[
				'787', '939'
			]
		@virNationalDestinationCode =
			[
				'340'
			]
		@nationalDestinationCode = @usaNationalDestinationCode.concat(@canadaNationalDestinationCode, @asmNationalDestinationCode, @gumNationalDestinationCode, @mnpNationalDestinationCode, @priNationalDestinationCode, @virNationalDestinationCode)

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		if withoutNDC.length is 7
			if ndc in @canadaNationalDestinationCode
				return new PhoneNumber('CAN', @countryCode, ndc, withoutNDC)
			else if ndc in @asmNationalDestinationCode
				return new PhoneNumber('ASM', @countryCode, ndc, withoutNDC)
			else if ndc in @gumNationalDestinationCode
				return new PhoneNumber('GUM', @countryCode, ndc, withoutNDC)
			else if ndc in @mnpNationalDestinationCode
				return new PhoneNumber('MNP', @countryCode, ndc, withoutNDC)
			else if ndc in @priNationalDestinationCode
				return new PhoneNumber('PRI', @countryCode, ndc, withoutNDC)
			else if ndc in @virNationalDestinationCode
				return new PhoneNumber('VIR', @countryCode, ndc, withoutNDC)
			else
				return new PhoneNumber('USA', @countryCode, ndc, withoutNDC)

	splitNumber: (number) =>
		if number.length is 7
			return Phone.compact number.split(/(\d{3})(\d{4})/)

		return [number]

# register
nanp = new NANP()
Phone.countries['1'] = nanp

# exports
module.exports = nanp
