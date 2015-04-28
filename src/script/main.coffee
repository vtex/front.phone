style = require('../style/style.less')

window.angular.module("app", ["vtex.phoneFilter"])
	.controller "AppCtrl", ($scope) ->
		$scope.getInfo = {value: "+1 (303) 448-1730"}
		$scope.format = {value: "+13034481730"}
		$scope.validate = {value: "+1 (303) 448-1730"}

		$scope.$watch 'getInfo.value', (v) ->
			result = vtex.phone.getPhoneInternational(v)
			$scope.getInfo.result = JSON.stringify(result, undefined, 2)

		$scope.$watch 'validate.value', (v) ->
			$scope.validate.result = vtex.phone.validate(v)
