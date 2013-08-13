root = exports ? this

# For more info check:
# https://www.numberingplans.com/?page=dialling&sub=areacodes
# http://en.wikipedia.org/wiki/Local_conventions_for_writing_telephone_numbers#Argentina

# WTF, Argentina?! I took me a really long time to UNDERSTAND what you
# guys were doing and after all of this saga, seriously, I still don't
# understand. 
# I'll try to help my fellow friends now. This is how argentinian phones
# works:
# ... ok, maybe later
class Argentina
	constructor: ->
		@countryCode = '54'
		@optionalTrunkPrefix = '0'
		@nationalNumberSeparator = '-'
		@nationalDestinationCode =
			[
				'9', '11', '220', '221', '223', '237', '261', '264', '291', '297', '299', '341', '342', '343', '345', '345', '351', '353', '358', '381', '385', '387', '388', '2202', '2221', '2223', '2224', '2225', '2226', '2227', '2229', '2241', '2242', '2243', '2244', '2245', '2246', '2252', '2254', '2255', '2257', '2261', '2262', '2264', '2265', '2266', '2267', '2268', '2271', '2272', '2273', '2274', '2281', '2283', '2284', '2285', '2286', '2291', '2292', '2293', '2296', '2297', '2302', '2314', '2316', '2317', '2320', '2322', '2323', '2324', '2325', '2326', '2331', '2333', '2334', '2335', '2337', '2338', '2342', '2343', '2344', '2345', '2346', '2352', '2353', '2354', '2355', '2356', '2357', '2358', '2362', '2392', '2393', '2394', '2395', '2396', '2473', '2474', '2475', '2477', '2478', '2622', '2623', '2624', '2625', '2626', '2627', '2646', '2647', '2648', '2651', '2652', '2655', '2656', '2657', '2658', '2901', '2902', '2903', '2920', '2921', '2922', '2923', '2924', '2925', '2926', '2927', '2928', '2929', '2931', '2932', '2933', '2934', '2935', '2936', '2940', '2941', '2942', '2944', '2945', '2946', '2948', '2952', '2953', '2954', '2962', '2963', '2964', '2965', '2966', '2972', '2982', '2983', '3327', '3329', '3382', '3385', '3387', '3388', '3400', '3401', '3402', '3404', '3405', '3406', '3407', '3408', '3409', '3435', '3436', '3437', '3438', '3442', '3444', '3445', '3446', '3447', '3454', '3455', '3456', '3458', '3460', '3461', '3462', '3463', '3464', '3465', '3466', '3467', '3468', '3469', '3471', '3472', '3476', '3482', '3483', '3487', '3488', '3489', '3491', '3492', '3493', '3496', '3497', '3498', '3521', '3522', '3524', '3525', '3532', '3533', '3534', '3541', '3542', '3543', '3544', '3546', '3547', '3548', '3549', '3562', '3563', '3564', '3571', '3572', '3573', '3574', '3575', '3576', '3582', '3583', '3584', '3585', '3711', '3715', '3716', '3717', '3718', '3721', '3722', '3725', '3731', '3732', '3734', '3735', '3741', '3743', '3751', '3752', '3754', '3755', '3756', '3757', '3758', '3772', '3773', '3774', '3775', '3777', '3781', '3782', '3783', '3786', '3821', '3822', '3825', '3826', '3827', '3832', '3833', '3835', '3837', '3838', '3841', '3843', '3844', '3845', '3846', '3854', '3855', '3856', '3857', '3858', '3861', '3862', '3863', '3865', '3867', '3868', '3869', '3875', '3876', '3877', '3878', '3884', '3885', '3886', '3887', '3891', '3892', '3894'
			]

	specialRules: (originalNumber, withoutCountryCode, withoutNDC, ndc) =>
		phone = new vtex.phone.PhoneNumber(@countryCode, ndc, withoutNDC, originalNumber)
		if (ndc.length + withoutNDC.length) is 10
			return phone
		else if ndc is '9'
				withoutCountryCode = withoutNDC

				ndcArray = @nationalDestinationCode.slice(1)
				for nationalDestinationCode in ndcArray
					ndcRegex = "^("+@optionalTrunkPrefix+"|)"+nationalDestinationCode
					ndcPattern = new RegExp ndcRegex

					if ndcPattern.test(withoutCountryCode)
						withoutNDC = withoutCountryCode.replace(ndcPattern, "")
						foundNationalDestinationCode = true
						break

				return null if !foundNationalDestinationCode
				phone.isMobile = true
				phone.nationalDestinationCode = nationalDestinationCode
				phone.number = withoutNDC
				return phone
		else
			if /^15/.test(withoutNDC) and (ndc.length + withoutNDC.length) is 12
				withoutNDC = withoutNDC.replace(/^15/, "")
				phone.isMobile = phone.has15 = true
				phone.number = withoutNDC
				return phone


	splitNumber: (number) =>
		switch number.length
			when 8
				splitNumber = number.split(/(\d{4})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1
			when 7
				splitNumber = number.split(/(\d{3})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1
			when 6
				splitNumber = number.split(/(\d{2})(\d{4})/)
				return _.filter splitNumber, (n) => n.length >= 1

		return [number]

	format: (phone, format = vtex.phone.INTERNATIONAL) =>
		resultString = ""

		splitNumber = vtex.phone.countries[phone.countryCode].splitNumber(phone.number)
		
		switch format
			when vtex.phone.INTERNATIONAL
				resultString = "+" + phone.countryCode + " "
				if phone.isMobile then resultString += "9 "
				if phone.nationalDestinationCode
					resultString += phone.nationalDestinationCode + " "
				resultString += splitNumber.join(" ")
			when vtex.phone.NATIONAL
				if phone.nationalDestinationCode
					resultString += "(" + phone.nationalDestinationCode + ") "
				separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator
				if phone.has15 then resultString += "15 "
				resultString += splitNumber.join(separator)
			when vtex.phone.LOCAL
				separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator
				resultString = splitNumber.join(separator)
			else
				resultString = ""

		return resultString

# exports
root.vtex.phone.countries = root.vtex.phone.countries || {}
root.vtex.phone.countries['54'] = new Argentina()