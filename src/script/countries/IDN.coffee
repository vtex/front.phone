
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

class Indonesia
	constructor: ->
		@countryName = "Indonesia"
		@countryNameAbbr = "IDN"
		@countryCode = '62'
		@regex = /^(?:\+62|\(0\d{2,3}\)|0)\s?(?:361|8[17]\s?\d?)?(?:[ -]?\d{3,4}){2,3}$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = ' '
		@nationalDestinationCode =
			["21","22","231","232","233","234","24","251","252","253","254","260","261","262","263","264","265","266","267","271","272","273","274","275","276","280","281","282","283","284","285","286","287","289","291","292","293","294","295","296","297","298","31","321","322","323","324","325","326","327","328","331","332","333","334","335","336","338","341","342","343","351","352","353","354","355","356","357","358","361","362","363","365","366","368","370","371","372","373","374","376","379","380","381","382","383","384","385","386","387","388","389","401","402","403","404","405","408","409","410","411","413","414","417","418","419","420","421","422","423","426","427","428","429","430","431","432","433","434","435","438","442","443","445","450","451","452","453","454","455","457","458","461","462","463","464","465","471","472","473","474","475","481","482","484","485","511","512","513","517","518","519","526","526","527","528","531","534","535","536","537","538","539","541","542","543","545","548","549","551","552","553","554","556","561","562","563","564","565","567","568","61","621","622","624","625","626","627","627","629","630","631","632","633","634","635","636","638","639","641","642","643","644","645","646","650","652","653","654","655","656","657","658","659","702","711","712","713","714","716","717","718","719","721","722","723","724","725","726","727","728","729","730","731","732","733","734","735","736","737","739","741","742","743","744","745","746","748","751","752","753","754","755","756","757","759","760","761","762","763","764","766","767","768","769","770","771","772","773","776","777","778","779","84","814","815","816","855","856","857","858","895","896","897","898","899","811","812","813","821","822","823","851","852","853","817","818","819","859","877","878","831","832","833","838","881","882","883","884","885","886","887","888","889","82","87","901","902","910","911","913","914","916","917","918","920","921","924","929","951","956","963","966","967","969","971","975","979","981","983","984","986"]
	
	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryNameAbbr, @countryCode, ndc, withoutNDC)

		switch withoutNDC.length
			when 8
				if ndc.length is 3 and ndc[0] is '8'
					phone.isMobile = true
					return phone
				if ndc.length is 2 or ndc.length is 3 then return phone
			when 7
				if ndc.length is 2 or ndc.length is 3 then return phone
			

	splitNumber: (number) =>
		switch number.length
			when 9
				return Phone.compact number.split(/(\d{3})(\d{3})(\d{3})/)
			when 10
				return Phone.compact number.split(/(\d{3})(\d{3})(\d{4})/)
			when 11
				return Phone.compact number.split(/(\d{3})(\d{4})(\d{4})/)
			when 12
				return Phone.compact number.split(/(\d{4})(\d{4})(\d{4})/)
			when 13
				return Phone.compact number.split(/(\d{5})(\d{4})(\d{4})/)

		return [number]

# register
indonesia = new Indonesia()
Phone.countries['62'] = indonesia

# exports
module.exports = indonesia
