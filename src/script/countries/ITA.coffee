
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://en.wikipedia.org/wiki/Telephone_numbers_in_Italy
class Spain
	constructor: ->
		@countryName = "Italy"
		@countryNameAbbr = "ITA"
		@countryCode = '39'
		@regex = /^(?:(?:\+|)39|)(?:0|)(?:(?:[03][1-9]\d{4,9}))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			[
				'010', '011', '0122', '0123', '0124', '0125', '0131', '0141', '015', '0161', '0163', '0165', '0166', '0171', '0183', '0184', '0185', '0187', '019', '02', '030', '031', '0321', '0322', '0324', '0331', '0332', '0341', '0342', '0343', '0344', '0345', '035', '0362', '0363', '0364', '0365', '0371', '0372', '0373', '0375', '0376', '0382', '039', '040', '041', '0421', '0422', '0423', '0424', '0425', '0426', '0429', '0431', '0432', '0434', '0438', '0444', '0445', '045', '0461', '0471', '0481', '049', '050', '051', '0521', '0522', '0523', '0532', '0535', '0536', '0541', '0543', '0544', '0545', '0547', '0549', '055', '0564', '0565', '0566', '0571', '0572', '0573', '0574', '0575', '0577', '0578', '0583', '0584', '0585', '0586', '0587', '0588', '059', '06', '070', '071', '0721', '0731', '0732', '0733', '0734', '0735', '0736', '0737', '075', '0761', '0765', '0771', '0773', '0774', '0775', '0776', '0782', '0783', '0784', '0789', '079', '080', '081', '0823', '0824', '0825', '0831', '0832', '085', '0861', '0862', '0865', '0874', '0881', '0882', '0883', '0884', '089', '0835', '090', '091', '0921', '0931', '0932', '0933', '0923', '0922', '0925', '0934', '0941', '0942', '095', '0961', '0962', '0963', '0965', '0974', '0975', '099', '0984', '310', '31100', '31101', '31105', '313', '319', '320', '324', '327', '328', '329', '330', '331', '333', '334', '335', '336', '337', '338', '339', '340', '342', '344', '345', '346', '347', '348', '349', '3505', '3510', '3512', '360', '366', '368', '370', '3710', '3711', '373', '377', '380', '385', '388', '389', '391', '392', '393'
			]

	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		if ndc.indexOf("3") is 0
			phone.isMobile = true
			phone.nationalDestinationCode = ''
			phone.number = withoutCountryCode
		else
			phone.isMobile = false

		return phone

	splitNumber: (number) =>
		if ndc.length is 5
			return Phone.compact number.split(/(\d{5})/)
		else if ndc.length is 4
			return Phone.compact number.split(/(\d{4})/)
		else if ndc.length is 3
			return Phone.compact number.split(/(\d{3})/)
		else if ndc.length is 2
			return Phone.compact number.split(/(\d{2})/)
		

		return [number]


# register
italy = new Italy()
Phone.countries['39'] = italy

# exports
module.exports = italy
