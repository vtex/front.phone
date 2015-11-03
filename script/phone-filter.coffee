window.angular.module('vtex.phoneFilter', [])
.filter('phone', ['$window', (($window) ->
	return (ph, toFormat, nationalCode) ->
		return 'N/A' unless ph

		if nationalCode
			phoneObject = $window.vtex.phone.getPhoneNational(ph, nationalCode)
		if !phoneObject or !nationalCode
			phoneObject = $window.vtex.phone.getPhoneInternational(ph)

		if !toFormat
			toFormat = $window.vtex.phone.INTERNATIONAL
		else
			toFormat = $window.vtex.phone[toFormat.toUpperCase()]

		return $window.vtex.phone.format(phoneObject, toFormat)
	)])
