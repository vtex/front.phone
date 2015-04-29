/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/@vtex/phone/script/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	window.angular.module('vtex.phoneFilter', []).filter('phone', function() {
	  return function(ph, toFormat, nationalCode) {
	    var phoneObject;
	    if (!ph) {
	      return 'N/A';
	    }
	    if (nationalCode) {
	      phoneObject = vtex.phone.getPhoneNational(ph, nationalCode);
	    }
	    if (!phoneObject || !nationalCode) {
	      phoneObject = vtex.phone.getPhoneInternational(ph);
	    }
	    if (!toFormat) {
	      toFormat = vtex.phone.INTERNATIONAL;
	    } else {
	      toFormat = vtex.phone[toFormat.toUpperCase()];
	    }
	    return vtex.phone.format(phoneObject, toFormat);
	  };
	});


/***/ }
/******/ ]);
//# sourceMappingURL=phone-filter.js.map