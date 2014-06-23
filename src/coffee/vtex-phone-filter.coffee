angular.module('vtex.phoneFilter', [])
.filter 'phone', ->
	return (ph) ->
		return 'N/A' unless ph
		phoneObject = vtex.phone.getPhoneInternational(ph)
		return vtex.phone.format(phoneObject, vtex.phone.INTERNATIONAL)
