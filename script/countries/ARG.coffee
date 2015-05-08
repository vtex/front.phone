
Phone = require('../Phone')
PhoneNumber = require('../PhoneNumber')

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://en.wikipedia.org/wiki/Local_conventions_for_writing_telephone_numbers#Argentina
# http://cambiodenumeracion.movistararg.com/index_t.html
class Argentina
	constructor: ->
		@countryName = "Argentina"
		@countryNameAbbr = "ARG"
		@countryCode = '54'
		@regex = /^(?:(?:\+|)54|)(?:0|)(?:(?:9(?:0|)(?:(?:11\d{8})|(?:2(?:20|21|23|30|36|37|49|60|61|63|64|66|80|91|94|97|98|99)|3(?:36|41|42|43|45|45|48|51|53|58|62|64|70|76|79|80|81|83|85|87|88))\d{7})|(?:2(?:2(?:02|21|23|24|25|26|27|29|41|42|43|44|45|46|52|54|55|57|61|62|64|65|66|67|68|71|72|73|74|81|83|84|85|86|91|92|96|97)|3(?:02|14|16|17|20|23|24|25|26|31|33|34|35|37|38|42|43|44|45|46|52|53|54|55|56|57|58|92|93|94|95|96)|4(?:73|74|75|77|78)|6(?:22|24|25|26|46|47|48|51|55|56|57|58)|9(?:01|02|03|20|21|22|23|24|25|26|27|28|29|31|32|33|34|35|36|40|42|45|46|48|52|53|54|62|63|64|66|72|82|83))|3(?:3(?:27|29|82|85|87|88)|4(?:00|01|02|04|05|06|07|08|09|35|36|37|38|42|44|45|46|47|54|55|56|58|60|62|63|64|65|66|67|68|69|71|72|76|82|83|87|89|91|92|93|96|97|98)|5(?:21|22|24|25|32|33|37|41|42|43|44|46|47|48|49|62|63|64|71|72|73|74|75|76|82|83|84|85)|7(?:11|15|16|18|21|25|31|34|35|41|43|51|54|55|56|57|58|72|73|74|75|77|81|82|86)|8(?:21|25|26|27|32|35|37|38|41|43|44|45|46|54|55|56|57|58|61|62|63|65|67|68|69|73|76|77|78|85|86|87|88|91|92|94))\d{6}))|(?:(?:11(?:15\d{8}|(?!15)\d{8}))|(?:(?:2(?:20|21|23|30|36|37|49|60|61|63|64|66|80|91|94|97|98|99)|3(?:36|41|42|43|45|45|48|51|53|58|62|64|70|76|79|80|81|83|85|87|88))(?:15\d{7}|(?!15)\d{7}))|(?:2(?:2(?:02|21|23|24|25|26|27|29|41|42|43|44|45|46|52|54|55|57|61|62|64|65|66|67|68|71|72|73|74|81|83|84|85|86|91|92|96|97)|3(?:02|14|16|17|20|23|24|25|26|31|33|34|35|37|38|42|43|44|45|46|52|53|54|55|56|57|58|92|93|94|95|96)|4(?:73|74|75|77|78)|6(?:22|24|25|26|46|47|48|51|55|56|57|58)|9(?:01|02|03|20|21|22|23|24|25|26|27|28|29|31|32|33|34|35|36|40|42|45|46|48|52|53|54|62|63|64|66|72|82|83))|3(?:3(?:27|29|82|85|87|88)|4(?:00|01|02|04|05|06|07|08|09|35|36|37|38|42|44|45|46|47|54|55|56|58|60|62|63|64|65|66|67|68|69|71|72|76|82|83|87|89|91|92|93|96|97|98)|5(?:21|22|24|25|32|33|37|41|42|43|44|46|47|48|49|62|63|64|71|72|73|74|75|76|82|83|84|85)|7(?:11|15|16|18|21|25|31|34|35|41|43|51|54|55|56|57|58|72|73|74|75|77|81|82|86)|8(?:21|25|26|27|32|35|37|38|41|43|44|45|46|54|55|56|57|58|61|62|63|65|67|68|69|73|76|77|78|85|86|87|88|91|92|94)))(?:15\d{6}|(?!15)\d{6})))$/
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = '-'
		@nationalDestinationCode =
			[
				'9', '11', '220', '221', '223', '230', '236','237', '249', '260', '261', '263', '264', '266', '280', '291', '294', '297', '298', '299', '336', '341', '342', '343', '345', '345', '348', '351', '353', '358', '362', '364', '370', '376', '379', '380', '381', '383', '385', '387', '388', '2202', '2221', '2223', '2224', '2225', '2226', '2227', '2229', '2241', '2242', '2243', '2244', '2245', '2246', '2252', '2254', '2255', '2257', '2261', '2262', '2264', '2265', '2266', '2267', '2268', '2271', '2272', '2273', '2274', '2281', '2283', '2284', '2285', '2286', '2291', '2292', '2296', '2297', '2302', '2314', '2316', '2317', '2320', '2323', '2324', '2325', '2326', '2331', '2333', '2334', '2335', '2337', '2338', '2342', '2343', '2344', '2345', '2346', '2352', '2353', '2354', '2355', '2356', '2357', '2358', '2392', '2393', '2394', '2395', '2396', '2473', '2474', '2475', '2477', '2478', '2622', '2624', '2625', '2626', '2646', '2647', '2648', '2651', '2655', '2656', '2657', '2658', '2901', '2902', '2903', '2920', '2921', '2922', '2923', '2924', '2925', '2926', '2927', '2928', '2929', '2931', '2932', '2933', '2934', '2935', '2936', '2940', '2942', '2945', '2946', '2948', '2952', '2953', '2954', '2962', '2963', '2964', '2966', '2972', '2982', '2983', '3327', '3329', '3382', '3385', '3387', '3388', '3400', '3401', '3402', '3404', '3405', '3406', '3407', '3408', '3409', '3435', '3436', '3437', '3438', '3442', '3444', '3445', '3446', '3447', '3454', '3455', '3456', '3458', '3460', '3462', '3463', '3464', '3465', '3466', '3467', '3468', '3469', '3471', '3472', '3476', '3482', '3483', '3487', '3489', '3491', '3492', '3493', '3496', '3497', '3498', '3521', '3522', '3524', '3525', '3532', '3533', '3537', '3541', '3542', '3543', '3544', '3546', '3547', '3548', '3549', '3562', '3563', '3564', '3571', '3572', '3573', '3574', '3575', '3576', '3582', '3583', '3584', '3585', '3711', '3715', '3716', '3718', '3721', '3725', '3731', '3734', '3735', '3741', '3743', '3751', '3754', '3755', '3756', '3757', '3758', '3772', '3773', '3774', '3775', '3777', '3781', '3782', '3786', '3821', '3825', '3826', '3827', '3832', '3835', '3837', '3838', '3841', '3843', '3844', '3845', '3846', '3854', '3855', '3856', '3857', '3858', '3861', '3862', '3863', '3865', '3867', '3868', '3869', '3873', '3876', '3877', '3878', '3885', '3886', '3887', '3888', '3891', '3892', '3894'
			]

	specialRules: (withoutCountryCode, withoutNDC, ndc) =>
		phone = new PhoneNumber(@countryCode, ndc, withoutNDC)
		if ndc is '9'
				withoutCountryCode = withoutNDC

				ndcArray = @nationalDestinationCode.slice(1)
				for nationalDestinationCode in ndcArray
					[foundNDC, ndcRegex] = Phone.testNDC(nationalDestinationCode, @, withoutCountryCode)
					break if foundNDC is true
				return null if !foundNDC
				withoutNDC = withoutCountryCode.replace(ndcRegex, "")
				return null if withoutNDC.length + nationalDestinationCode.length isnt 10

				phone.isMobile = true
				phone.nationalDestinationCode = nationalDestinationCode
				phone.number = withoutNDC
				return phone
		else if /^15/.test(withoutNDC) and (ndc.length + withoutNDC.length) is 12
				withoutNDC = withoutNDC.replace(/^15/, "")
				phone.isMobile = true
				phone.number = withoutNDC
				return phone
		else if (ndc.length + withoutNDC.length) is 10
			return phone


	splitNumber: (number) =>
		switch number.length
			when 8
				return Phone.compact number.split(/(\d{4})(\d{4})/)
			when 7
				return Phone.compact number.split(/(\d{3})(\d{4})/)
			when 6
				return Phone.compact number.split(/(\d{2})(\d{4})/)

		return [number]

	format: (phone, format = Phone.INTERNATIONAL) =>
		resultString = ""

		splitNumber = Phone.countries[phone.countryCode].splitNumber(phone.number)

		switch format
			when Phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				if phone.isMobile then resultString += "9 "
				if phone.nationalDestinationCode
					resultString += phone.nationalDestinationCode + " "
				resultString += splitNumber.join(" ")
			when Phone.NATIONAL
				if phone.nationalDestinationCode
					resultString += "(" + phone.nationalDestinationCode + ") "
				separator = Phone.countries[phone.countryCode].nationalNumberSeparator
				if phone.isMobile then resultString += "15 "
				resultString += splitNumber.join(separator)
			when Phone.LOCAL
				separator = Phone.countries[phone.countryCode].nationalNumberSeparator
				resultString = splitNumber.join(separator)
			else
				resultString = ""

		return resultString

# register
argentina = new Argentina()
Phone.countries['54'] = argentina

# exports
module.exports = argentina
