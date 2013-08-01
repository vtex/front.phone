window.vtex = window.vtex || {}
window.vtex.phone = window.vtex.phone || {}
window.vtex.phone.countries = window.vtex.phone.countries || {}

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# (1) http://www.anatel.gov.br/Portal/exibirPortalPaginaEspecialPesquisa.do?acao=&tipoConteudoHtml=1&codNoticia=27199
# http://en.wikipedia.org/wiki/Local_conventions_for_writing_telephone_numbers#Brazil
class Brazil
	constructor: ->
		@countryCode = '55'
		@initialOptionalDigit = '0'
		@nationalDestinationCode =
			[
 				'11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '27', '28', '31', '32', '33', '34', '35', '36', '37', '38', '41', '42', '43', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '61', '62', '63', '64', '65', '66', '67', '68', '69', '71', '72', '73', '74', '75', '77', '78', '79', '81', '82', '83', '84', '85', '86', '87', '88', '89', '91', '92', '93', '94', '95', '96', '97', '98', '99'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>
		# Needs to be updated in 2015 (as in link (1) above)
		newMobileNDC = ['11','12','13','14','15','16','17','18','19','21','22','24','27','28']
		newMobilePattern = new RegExp "^(0|)("+newMobileNDC.join("|")+")"
		ndcRest = withoutCountryCode.replace(newMobilePattern, "")
		
		if ndcRest.length < withoutCountryCode.length			
			return ndcRest.length is 9 or ndcRest.length is 8
		else
			return withoutNDC.length is 8
			
window.vtex.phone.countries['55'] = new Brazil()