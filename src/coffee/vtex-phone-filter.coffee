angular.module('vtex.phoneFilter', [])
.filter 'phone', ->
	return (ph, toFormat, nationalCode) ->
		return 'N/A' unless ph

		if nationalCode
			phoneObject = vtex.phone.getPhoneNational(ph, nationalCode)
		if !phoneObject or !nationalCode
			phoneObject = vtex.phone.getPhoneInternational(ph)

		if !toFormat
			toFormat = vtex.phone.INTERNATIONAL
		else
			toFormat = vtex.phone[toFormat.toUpperCase()]

		return vtex.phone.format(phoneObject, toFormat)
