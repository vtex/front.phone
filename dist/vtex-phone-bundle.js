(function() {
  var Phone, PhoneNumber, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  PhoneNumber = (function() {
    function PhoneNumber(countryCode, nationalDestinationCode, number) {
      this.valid = __bind(this.valid, this);
      this.countryCode = countryCode;
      this.nationalDestinationCode = nationalDestinationCode;
      this.number = number;
      this.isMobile = null;
    }

    PhoneNumber.prototype.valid = function(isValid) {
      return this.valid = isValid;
    };

    return PhoneNumber;

  })();

  Phone = (function() {
    function Phone() {
      this.getCountryCodeByNameAbbr = __bind(this.getCountryCodeByNameAbbr, this);
      this.getCountryCodeByName = __bind(this.getCountryCodeByName, this);
      this.format = __bind(this.format, this);
      this.testNDC = __bind(this.testNDC, this);
      this.testCountryCode = __bind(this.testCountryCode, this);
      this.validate = __bind(this.validate, this);
      this.compact = __bind(this.compact, this);
      this.normalize = __bind(this.normalize, this);
      this.getPhoneInternational = __bind(this.getPhoneInternational, this);
      this.getPhoneNational = __bind(this.getPhoneNational, this);
      this.INTERNATIONAL = 0;
      this.NATIONAL = 1;
      this.LOCAL = 2;
    }

    Phone.prototype.getPhoneNational = function(nationalNumber, givenCountryCode, givenNationalDestinationCode) {
      var countryObj, foundNDC, nationalDestinationCode, ndcRegex, phoneNumber, withoutNDC, _i, _len, _ref, _ref1, _ref2;
      if (nationalNumber === null) {
        return null;
      }
      nationalNumber = this.normalize(nationalNumber);
      countryObj = root.vtex.phone.countries[givenCountryCode];
      if (!countryObj) {
        return null;
      }
      if (givenNationalDestinationCode) {
        nationalDestinationCode = givenNationalDestinationCode;
        _ref = this.testNDC(nationalDestinationCode, countryObj, nationalNumber), foundNDC = _ref[0], ndcRegex = _ref[1];
      } else {
        _ref1 = countryObj.nationalDestinationCode;
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          nationalDestinationCode = _ref1[_i];
          _ref2 = this.testNDC(nationalDestinationCode, countryObj, nationalNumber), foundNDC = _ref2[0], ndcRegex = _ref2[1];
          if (foundNDC === true) {
            break;
          }
        }
      }
      if (!foundNDC) {
        return null;
      }
      withoutNDC = nationalNumber.replace(ndcRegex, "");
      phoneNumber = countryObj.specialRules(nationalNumber, withoutNDC, nationalDestinationCode);
      if (phoneNumber) {
        phoneNumber.valid(true);
        return phoneNumber;
      } else {
        return null;
      }
    };

    Phone.prototype.getPhoneInternational = function(number, givenCountryCode, givenNationalDestinationCode) {
      var countryCode, countryCodeRegex, countryObj, foundCountryCode, withoutCountryCode, _ref, _ref1, _ref2;
      if (number === null) {
        return null;
      }
      number = this.normalize(number);
      if (givenCountryCode) {
        countryCode = givenCountryCode;
        _ref = this.testCountryCode(countryCode, number), foundCountryCode = _ref[0], countryCodeRegex = _ref[1];
      } else {
        _ref1 = vtex.phone.countries;
        for (countryCode in _ref1) {
          countryObj = _ref1[countryCode];
          _ref2 = this.testCountryCode(countryCode, number), foundCountryCode = _ref2[0], countryCodeRegex = _ref2[1];
          if (foundCountryCode === true) {
            break;
          }
        }
      }
      if (!foundCountryCode) {
        return null;
      }
      withoutCountryCode = number.replace(countryCodeRegex, "");
      return this.getPhoneNational(withoutCountryCode, countryCode, givenNationalDestinationCode);
    };

    Phone.prototype.normalize = function(number) {
      return number.replace(/\ |\(|\)|\-|\.|[A-z]|\+/g, "");
    };

    Phone.prototype.compact = function(array) {
      var element, newArray, _i, _len;
      newArray = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        element = array[_i];
        if (element !== "") {
          newArray.push(element);
        }
      }
      return newArray;
    };

    Phone.prototype.validate = function(number, givenCountryCode) {
      var countryCode, countryObj, valid, _ref;
      if (number === null) {
        return false;
      }
      number = this.normalize(number);
      if (givenCountryCode) {
        return vtex.phone.countries[givenCountryCode].regex.test(number);
      } else {
        valid = false;
        _ref = vtex.phone.countries;
        for (countryCode in _ref) {
          countryObj = _ref[countryCode];
          if (countryObj.regex.test(number)) {
            valid = true;
            break;
          }
        }
        return valid;
      }
    };

    Phone.prototype.testCountryCode = function(countryCode, number) {
      var countryCodeRegex;
      countryCodeRegex = new RegExp("^" + countryCode);
      if (countryCodeRegex.test(number)) {
        return [true, countryCodeRegex];
      } else {
        return [false, null];
      }
    };

    Phone.prototype.testNDC = function(nationalDestinationCode, countryObj, number) {
      var ndcPattern, ndcRegex;
      ndcPattern = "^(" + countryObj.optionalTrunkPrefix + "|)" + nationalDestinationCode;
      ndcRegex = new RegExp(ndcPattern);
      if (ndcRegex.test(number)) {
        return [true, ndcRegex];
      } else {
        return [false, null];
      }
    };

    Phone.prototype.format = function(phone, format) {
      var resultString, separator, splitNumber;
      if (format == null) {
        format = vtex.phone.INTERNATIONAL;
      }
      if (phone === null) {
        return null;
      }
      if (vtex.phone.countries[phone.countryCode].format) {
        return vtex.phone.countries[phone.countryCode].format(phone, format);
      }
      resultString = "";
      splitNumber = vtex.phone.countries[phone.countryCode].splitNumber(phone.number);
      switch (format) {
        case vtex.phone.INTERNATIONAL:
          resultString = "+" + phone.countryCode + " ";
          if (phone.nationalDestinationCode) {
            resultString += phone.nationalDestinationCode + " ";
          }
          resultString += splitNumber.join(" ");
          break;
        case vtex.phone.NATIONAL:
          if (phone.nationalDestinationCode) {
            resultString += "(" + phone.nationalDestinationCode + ") ";
          }
          separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator;
          resultString += splitNumber.join(separator);
          break;
        case vtex.phone.LOCAL:
          separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator;
          resultString = splitNumber.join(separator);
      }
      return resultString;
    };

    Phone.prototype.getCountryCodeByName = function(name) {
      var key, value, _ref;
      _ref = vtex.phone.countries;
      for (key in _ref) {
        value = _ref[key];
        if (value.countryName === name) {
          return value.countryCode;
        }
      }
    };

    Phone.prototype.getCountryCodeByNameAbbr = function(nameAbbr) {
      var key, value, _ref;
      _ref = vtex.phone.countries;
      for (key in _ref) {
        value = _ref[key];
        if (value.countryNameAbbr === nameAbbr) {
          return value.countryCode;
        }
      }
    };

    return Phone;

  })();

  root.vtex = root.vtex || {};

  root.vtex.phone = new Phone();

  root.vtex.phone.PhoneNumber = PhoneNumber;

}).call(this);

(function() {
  var Argentina, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Argentina = (function() {
    function Argentina() {
      this.format = __bind(this.format, this);
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Argentina";
      this.countryNameAbbr = "ARG";
      this.countryCode = '54';
      this.regex = /^(?:(?:\+|)54|)(?:0|)(?:(?:9(?:0|)(?:(?:11\d{8})|(?:(?:220|221|223|230|236|237|249|260|261|263|264|266|280|291|294|297|298|299|336|341|342|343|345|345|348|351|353|358|362|364|370|376|379|380|381|383|385|387|388)\d{7})|(?:2202|2221|2223|2224|2225|2226|2227|2229|2241|2242|2243|2244|2245|2246|2252|2254|2255|2257|2261|2262|2264|2265|2266|2267|2268|2271|2272|2273|2274|2281|2283|2284|2285|2286|2291|2292|2296|2297|2302|2314|2316|2317|2320|2323|2324|2325|2326|2331|2333|2334|2335|2337|2338|2342|2343|2344|2345|2346|2352|2353|2354|2355|2356|2357|2358|2392|2393|2394|2395|2396|2473|2474|2475|2477|2478|2622|2624|2625|2626|2646|2647|2648|2651|2655|2656|2657|2658|2901|2902|2903|2920|2921|2922|2923|2924|2925|2926|2927|2928|2929|2931|2932|2933|2934|2935|2936|2940|2942|2945|2946|2948|2952|2953|2954|2962|2963|2964|2966|2972|2982|2983|3327|3329|3382|3385|3387|3388|3400|3401|3402|3404|3405|3406|3407|3408|3409|3435|3436|3437|3438|3442|3444|3445|3446|3447|3454|3455|3456|3458|3460|3462|3463|3464|3465|3466|3467|3468|3469|3471|3472|3476|3482|3483|3487|3489|3491|3492|3493|3496|3497|3498|3521|3522|3524|3525|3532|3533|3537|3541|3542|3543|3544|3546|3547|3548|3549|3562|3563|3564|3571|3572|3573|3574|3575|3576|3582|3583|3584|3585|3711|3715|3716|3718|3721|3725|3731|3734|3735|3741|3743|3751|3754|3755|3756|3757|3758|3772|3773|3774|3775|3777|3781|3782|3786|3821|3825|3826|3827|3832|3835|3837|3838|3841|3843|3844|3845|3846|3854|3855|3856|3857|3858|3861|3862|3863|3865|3867|3868|3869|3873|3876|3877|3878|3885|3886|3887|3888|3891|3892|3894)\d{6}))|(?:(?:11(?:15\d{8}|(?!15)\d{8}))|(?:(?:220|221|223|230|236|237|249|260|261|263|264|266|280|291|294|297|2299|336|341|342|343|345|345|348|351|353|358|362|364|370|376|379|380|381|383|385|387|388)(?:15\d{7}|(?!15)\d{7}))|(?:2202|2221|2223|2224|2225|2226|2227|2229|2241|2242|2243|2244|2245|2246|2252|2254|2255|2257|2261|2262|2264|2265|2266|2267|2268|2271|2272|2273|2274|2281|2283|2284|2285|2286|2291|2292|2296|2297|2302|2314|2316|2317|2320|2323|2324|2325|2326|2331|2333|2334|2335|2337|2338|2342|2343|2344|2345|2346|2352|2353|2354|2355|2356|2357|2358|2392|2393|2394|2395|2396|2473|2474|2475|2477|2478|2622|2624|2625|2626|2646|2647|2648|2651|2655|2656|2657|2658|2901|2902|2903|2920|2921|2922|2923|2924|2925|2926|2927|2928|2929|2931|2932|2933|2934|2935|2936|2940|2942|2945|2946|2948|2952|2953|2954|2962|2963|2964|2966|2972|2982|2983|3327|3329|3382|3385|3387|3388|3400|3401|3402|3404|3405|3406|3407|3408|3409|3435|3436|3437|3438|3442|3444|3445|3446|3447|3454|3455|3456|3458|3460|3462|3463|3464|3465|3466|3467|3468|3469|3471|3472|3476|3482|3483|3487|3489|3491|3492|3493|3496|3497|3498|3521|3522|3524|3525|3532|3533|3537|3541|3542|3543|3544|3546|3547|3548|3549|3562|3563|3564|3571|3572|3573|3574|3575|3576|3582|3583|3584|3585|3711|3715|3716|3718|3721|3725|3731|3734|3735|3741|3743|3751|3754|3755|3756|3757|3758|3772|3773|3774|3775|3777|3781|3782|3786|3821|3825|3826|3827|3832|3835|3837|3838|3841|3843|3844|3845|3846|3854|3855|3856|3857|3858|3861|3862|3863|3865|3867|3868|3869|3873|3876|3877|3878|3885|3886|3887|3888|3891|3892|3894)(?:15\d{6}|(?!15)\d{6})))$/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = '-';
      this.nationalDestinationCode = ['9', '11', '220', '221', '223', '230', '236', '237', '249', '260', '261', '263', '264', '266', '280', '291', '294', '297', '298', '299', '336', '341', '342', '343', '345', '345', '348', '351', '353', '358', '362', '364', '370', '376', '379', '380', '381', '383', '385', '387', '388', '2202', '2221', '2223', '2224', '2225', '2226', '2227', '2229', '2241', '2242', '2243', '2244', '2245', '2246', '2252', '2254', '2255', '2257', '2261', '2262', '2264', '2265', '2266', '2267', '2268', '2271', '2272', '2273', '2274', '2281', '2283', '2284', '2285', '2286', '2291', '2292', '2296', '2297', '2302', '2314', '2316', '2317', '2320', '2323', '2324', '2325', '2326', '2331', '2333', '2334', '2335', '2337', '2338', '2342', '2343', '2344', '2345', '2346', '2352', '2353', '2354', '2355', '2356', '2357', '2358', '2392', '2393', '2394', '2395', '2396', '2473', '2474', '2475', '2477', '2478', '2622', '2624', '2625', '2626', '2646', '2647', '2648', '2651', '2655', '2656', '2657', '2658', '2901', '2902', '2903', '2920', '2921', '2922', '2923', '2924', '2925', '2926', '2927', '2928', '2929', '2931', '2932', '2933', '2934', '2935', '2936', '2940', '2942', '2945', '2946', '2948', '2952', '2953', '2954', '2962', '2963', '2964', '2966', '2972', '2982', '2983', '3327', '3329', '3382', '3385', '3387', '3388', '3400', '3401', '3402', '3404', '3405', '3406', '3407', '3408', '3409', '3435', '3436', '3437', '3438', '3442', '3444', '3445', '3446', '3447', '3454', '3455', '3456', '3458', '3460', '3462', '3463', '3464', '3465', '3466', '3467', '3468', '3469', '3471', '3472', '3476', '3482', '3483', '3487', '3489', '3491', '3492', '3493', '3496', '3497', '3498', '3521', '3522', '3524', '3525', '3532', '3533', '3537', '3541', '3542', '3543', '3544', '3546', '3547', '3548', '3549', '3562', '3563', '3564', '3571', '3572', '3573', '3574', '3575', '3576', '3582', '3583', '3584', '3585', '3711', '3715', '3716', '3718', '3721', '3725', '3731', '3734', '3735', '3741', '3743', '3751', '3754', '3755', '3756', '3757', '3758', '3772', '3773', '3774', '3775', '3777', '3781', '3782', '3786', '3821', '3825', '3826', '3827', '3832', '3835', '3837', '3838', '3841', '3843', '3844', '3845', '3846', '3854', '3855', '3856', '3857', '3858', '3861', '3862', '3863', '3865', '3867', '3868', '3869', '3873', '3876', '3877', '3878', '3885', '3886', '3887', '3888', '3891', '3892', '3894'];
    }

    Argentina.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var foundNDC, nationalDestinationCode, ndcArray, ndcRegex, phone, _i, _len, _ref;
      phone = new vtex.phone.PhoneNumber(this.countryCode, ndc, withoutNDC);
      if (ndc === '9') {
        withoutCountryCode = withoutNDC;
        ndcArray = this.nationalDestinationCode.slice(1);
        for (_i = 0, _len = ndcArray.length; _i < _len; _i++) {
          nationalDestinationCode = ndcArray[_i];
          _ref = vtex.phone.testNDC(nationalDestinationCode, this, withoutCountryCode), foundNDC = _ref[0], ndcRegex = _ref[1];
          if (foundNDC === true) {
            break;
          }
        }
        if (!foundNDC) {
          return null;
        }
        withoutNDC = withoutCountryCode.replace(ndcRegex, "");
        if (withoutNDC.length + nationalDestinationCode.length !== 10) {
          return null;
        }
        phone.isMobile = true;
        phone.nationalDestinationCode = nationalDestinationCode;
        phone.number = withoutNDC;
        return phone;
      } else if (/^15/.test(withoutNDC) && (ndc.length + withoutNDC.length) === 12) {
        withoutNDC = withoutNDC.replace(/^15/, "");
        phone.isMobile = true;
        phone.number = withoutNDC;
        return phone;
      } else if ((ndc.length + withoutNDC.length) === 10) {
        return phone;
      }
    };

    Argentina.prototype.splitNumber = function(number) {
      switch (number.length) {
        case 8:
          return vtex.phone.compact(number.split(/(\d{4})(\d{4})/));
        case 7:
          return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
        case 6:
          return vtex.phone.compact(number.split(/(\d{2})(\d{4})/));
      }
      return [number];
    };

    Argentina.prototype.format = function(phone, format) {
      var resultString, separator, splitNumber;
      if (format == null) {
        format = vtex.phone.INTERNATIONAL;
      }
      resultString = "";
      splitNumber = vtex.phone.countries[phone.countryCode].splitNumber(phone.number);
      switch (format) {
        case vtex.phone.INTERNATIONAL:
          resultString = "+" + phone.countryCode + " ";
          if (phone.isMobile) {
            resultString += "9 ";
          }
          if (phone.nationalDestinationCode) {
            resultString += phone.nationalDestinationCode + " ";
          }
          resultString += splitNumber.join(" ");
          break;
        case vtex.phone.NATIONAL:
          if (phone.nationalDestinationCode) {
            resultString += "(" + phone.nationalDestinationCode + ") ";
          }
          separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator;
          if (phone.isMobile) {
            resultString += "15 ";
          }
          resultString += splitNumber.join(separator);
          break;
        case vtex.phone.LOCAL:
          separator = vtex.phone.countries[phone.countryCode].nationalNumberSeparator;
          resultString = splitNumber.join(separator);
          break;
        default:
          resultString = "";
      }
      return resultString;
    };

    return Argentina;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['54'] = new Argentina();

}).call(this);

(function() {
  var Brazil, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Brazil = (function() {
    function Brazil() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Brazil";
      this.countryNameAbbr = "BRA";
      this.countryCode = '55';
      this.regex = /^(((\+|)(55|)|))(0|)(((11|12|13|14|15|16|17|18|19|21|22|24|27|28)(9\d{8}|\d{8})$)|((11|12|13|14|15|16|17|18|19|21|22|24|27|28|31|32|33|34|35|36|37|38|41|42|43|44|45|46|47|48|49|51|52|53|54|55|61|62|63|64|65|66|67|68|69|71|72|73|74|75|77|78|79|81|82|83|84|85|86|87|88|89|91|92|93|94|95|96|97|98|99)\d{8}$))/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = '-';
      this.nationalDestinationCode = ['11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '27', '28', '31', '32', '33', '34', '35', '36', '37', '38', '41', '42', '43', '44', '45', '46', '47', '48', '49', '51', '52', '53', '54', '55', '61', '62', '63', '64', '65', '66', '67', '68', '69', '71', '72', '73', '74', '75', '77', '78', '79', '81', '82', '83', '84', '85', '86', '87', '88', '89', '91', '92', '93', '94', '95', '96', '97', '98', '99'];
    }

    Brazil.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var ndcRest, newMobileNDC, newMobilePattern, phone;
      newMobileNDC = ['11', '12', '13', '14', '15', '16', '17', '18', '19', '21', '22', '24', '27', '28'];
      newMobilePattern = new RegExp("^(0|)(" + newMobileNDC.join("|") + ")");
      phone = new vtex.phone.PhoneNumber(this.countryCode, ndc, withoutNDC);
      if (newMobilePattern.test(withoutCountryCode)) {
        ndcRest = withoutCountryCode.replace(newMobilePattern, "");
        if (ndcRest.length === 9 || ndcRest.length === 8) {
          return phone;
        }
      } else {
        if (withoutNDC.length === 8) {
          return phone;
        }
      }
    };

    Brazil.prototype.splitNumber = function(number) {
      if (number.length === 8) {
        return vtex.phone.compact(number.split(/(\d{4})(\d{4})/));
      } else if (number.length === 9) {
        if (number.indexOf("9") === 0) {
          return vtex.phone.compact(number.split(/(\d{5})(\d{4})/));
        }
      }
      return [number];
    };

    return Brazil;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['55'] = new Brazil();

}).call(this);

(function() {
  var Chile, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Chile = (function() {
    function Chile() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Chile";
      this.countryNameAbbr = "CHL";
      this.countryCode = '56';
      this.regex = /^(?:(?:\+|)56|)(?:0|)(?:(?:(?:2|9)\d{8})|(?:58\d{7})|(?:(?:3[2345]|4[1235]|5[123578]|6[134578]|7[1235])\d{6,7}))$/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = ' ';
      this.nationalDestinationCode = ['2', '32', '33', '34', '35', '41', '42', '43', '45', '51', '52', '53', '55', '57', '58', '61', '63', '64', '65', '67', '68', '71', '72', '73', '75', '9'];
    }

    Chile.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var phone;
      phone = new vtex.phone.PhoneNumber(this.countryCode, ndc, withoutNDC);
      switch (ndc) {
        case '2':
          if (withoutNDC.length === 8) {
            return phone;
          }
          break;
        case '9':
          if (withoutNDC.length === 8) {
            phone.isMobile = true;
            phone.nationalDestinationCode = '';
            phone.number = withoutCountryCode;
            return phone;
          }
          break;
        case '58':
          if (withoutNDC.length === 7) {
            return phone;
          }
          break;
        default:
          if (withoutNDC.length === 6 || withoutNDC.length === 7) {
            return phone;
          }
      }
    };

    Chile.prototype.splitNumber = function(number) {
      switch (number.length) {
        case 9:
          return vtex.phone.compact(number.split(/(\d{1})(\d{4})(\d{4})/));
        case 8:
          return vtex.phone.compact(number.split(/(\d{4})(\d{4})/));
        case 7:
          return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
        case 6:
          return vtex.phone.compact(number.split(/(\d{2})(\d{4})/));
      }
      return [number];
    };

    return Chile;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['56'] = new Chile();

}).call(this);

(function() {
  var Colombia, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Colombia = (function() {
    function Colombia() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Colombia";
      this.countryNameAbbr = "COL";
      this.countryCode = '57';
      this.regex = /^(?:(?:\+|)57|)(?:0|)(?:(?:[12345678]\d{7})|(?:3\d{9}))$/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = ' ';
      this.nationalDestinationCode = ['3(\\d{2})', '1', '2', '3', '4', '5', '6', '7', '8'];
    }

    Colombia.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var phone;
      phone = new vtex.phone.PhoneNumber(this.countryCode, '', withoutNDC);
      if (withoutCountryCode.indexOf('3') === 0 && withoutCountryCode.length === 10) {
        phone.isMobile = true;
        phone.number = withoutCountryCode;
        phone.nationalDestinationCode = '';
        return phone;
      } else {
        if (withoutNDC.length === 7) {
          phone.nationalDestinationCode = ndc;
          return phone;
        }
      }
    };

    Colombia.prototype.splitNumber = function(number) {
      if (number.length === 7) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
      } else if (number.length === 10) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{3})(\d{4})/));
      }
      return [number];
    };

    return Colombia;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['57'] = new Colombia();

}).call(this);

(function() {
  var Ecuador, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Ecuador = (function() {
    function Ecuador() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Ecuador";
      this.countryNameAbbr = "ECU";
      this.countryCode = '593';
      this.regex = /^(?:(?:(?:\+|)593)|)(?:0|)(?:(?:(?:[234567])\d{7})|(?:9\d{8}))$/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = ' ';
      this.nationalDestinationCode = ['2', '3', '4', '5', '6', '7', '9'];
    }

    Ecuador.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var phone;
      phone = new vtex.phone.PhoneNumber(this.countryCode, ndc, withoutNDC);
      if (withoutNDC.length === 7 && ndc !== '9') {
        return phone;
      } else if (ndc === '9' && withoutNDC.length === 8) {
        phone.isMobile = true;
        phone.number = withoutCountryCode;
        phone.nationalDestinationCode = '';
        return phone;
      }
    };

    Ecuador.prototype.splitNumber = function(number) {
      if (number.length === 7) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
      } else if (number.length === 9) {
        if (number.indexOf("9") === 0) {
          return vtex.phone.compact(number.split(/(\d{2})(\d{3})(\d{4})/));
        }
      }
      return [number];
    };

    return Ecuador;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['593'] = new Ecuador();

}).call(this);

(function() {
  var Uruguay, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Uruguay = (function() {
    function Uruguay() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Uruguay";
      this.countryNameAbbr = "URY";
      this.countryCode = '598';
      this.regex = /^(?:(?:\+|)598|)(?:0|)(?:[249]\d{7})$/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = ' ';
      this.nationalDestinationCode = ['2', '4', '9'];
    }

    Uruguay.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var phone;
      phone = new vtex.phone.PhoneNumber(this.countryCode, ndc, withoutNDC);
      if ((ndc.length + withoutNDC.length) === 8) {
        if (ndc === '9') {
          phone.isMobile = true;
        }
        phone.nationalDestinationCode = '';
        phone.number = withoutCountryCode;
        return phone;
      }
    };

    Uruguay.prototype.splitNumber = function(number) {
      if (number.length === 7) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
      } else if (number.length === 8) {
        return vtex.phone.compact(number.split(/(\d{4})(\d{4})/));
      }
      return [number];
    };

    return Uruguay;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['598'] = new Uruguay();

}).call(this);

(function() {
  var USA, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  USA = (function() {
    function USA() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "USA";
      this.countryNameAbbr = "USA";
      this.countryCode = '1';
      this.regex = /^(?:(?:(?:\+|)(?:1|))|)(?:1|)(?:201|202|203|205|206|207|208|209|209|210|212|213|214|215|216|217|218|219|224|225|227|228|229|231|234|239|240|248|251|252|253|254|256|260|262|267|269|270|274|276|278|281|283|301|302|303|304|305|307|308|309|310|312|313|314|315|316|317|318|319|320|321|323|325|330|331|334|336|337|339|341|347|351|352|360|361|364|369|380|385|386|401|402|404|405|406|407|408|409|410|412|413|414|415|417|419|423|424|425|430|432|434|435|440|442|443|445|447|458|464|469|470|475|478|479|480|484|501|502|503|504|505|507|508|509|510|512|513|515|516|517|518|520|530|531|534|540|541|551|557|559|561|562|563|564|567|570|571|573|574|575|580|585|586|601|602|603|605|606|607|608|609|610|612|614|615|616|617|618|619|620|623|626|627|628|630|631|636|641|646|650|651|657|659|660|661|662|667|669|678|679|681|682|689|701|702|703|704|706|707|708|712|713|714|715|716|717|718|719|720|724|727|730|731|732|734|737|740|747|752|754|757|760|762|763|764|765|769|770|772|773|774|775|779|781|785|786|801|802|803|804|805|806|808|810|812|813|814|815|816|817|818|828|830|831|832|835|843|845|847|848|850|856|857|858|859|860|862|863|864|865|870|872|878|901|903|904|906|907|908|909|910|912|913|914|915|916|917|918|919|920|925|927|928|931|935|936|937|938|940|941|947|949|951|952|954|956|957|959|970|971|972|973|975|978|979|980|984|985|989)\d{7}$/;
      this.optionalTrunkPrefix = '1';
      this.nationalNumberSeparator = ' ';
      this.nationalDestinationCode = ['201', '202', '203', '205', '206', '207', '208', '209', '209', '210', '212', '213', '214', '215', '216', '217', '218', '219', '224', '225', '227', '228', '229', '231', '234', '239', '240', '248', '251', '252', '253', '254', '256', '260', '262', '267', '269', '270', '274', '276', '278', '281', '283', '301', '302', '303', '304', '305', '307', '308', '309', '310', '312', '313', '314', '315', '316', '317', '318', '319', '320', '321', '323', '325', '330', '331', '334', '336', '337', '339', '341', '347', '351', '352', '360', '361', '364', '369', '380', '385', '386', '401', '402', '404', '405', '406', '407', '408', '409', '410', '412', '413', '414', '415', '417', '419', '423', '424', '425', '430', '432', '434', '435', '440', '442', '443', '445', '447', '458', '464', '469', '470', '475', '478', '479', '480', '484', '501', '502', '503', '504', '505', '507', '508', '509', '510', '512', '513', '515', '516', '517', '518', '520', '530', '531', '534', '540', '541', '551', '557', '559', '561', '562', '563', '564', '567', '570', '571', '573', '574', '575', '580', '585', '586', '601', '602', '603', '605', '606', '607', '608', '609', '610', '612', '614', '615', '616', '617', '618', '619', '620', '623', '626', '627', '628', '630', '631', '636', '641', '646', '650', '651', '657', '659', '660', '661', '662', '667', '669', '678', '679', '681', '682', '689', '701', '702', '703', '704', '706', '707', '708', '712', '713', '714', '715', '716', '717', '718', '719', '720', '724', '727', '730', '731', '732', '734', '737', '740', '747', '752', '754', '757', '760', '762', '763', '764', '765', '769', '770', '772', '773', '774', '775', '779', '781', '785', '786', '801', '802', '803', '804', '805', '806', '808', '810', '812', '813', '814', '815', '816', '817', '818', '828', '830', '831', '832', '835', '843', '845', '847', '848', '850', '856', '857', '858', '859', '860', '862', '863', '864', '865', '870', '872', '878', '901', '903', '904', '906', '907', '908', '909', '910', '912', '913', '914', '915', '916', '917', '918', '919', '920', '925', '927', '928', '931', '935', '936', '937', '938', '940', '941', '947', '949', '951', '952', '954', '956', '957', '959', '970', '971', '972', '973', '975', '978', '979', '980', '984', '985', '989'];
    }

    USA.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      if (withoutNDC.length === 7) {
        return new vtex.phone.PhoneNumber(this.countryCode, ndc, withoutNDC);
      }
    };

    USA.prototype.splitNumber = function(number) {
      if (number.length === 7) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
      }
      return [number];
    };

    return USA;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['1'] = new USA();

}).call(this);

(function() {
  var Peru, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  Peru = (function() {
    function Peru() {
      this.splitNumber = __bind(this.splitNumber, this);
      this.specialRules = __bind(this.specialRules, this);
      this.countryName = "Peru";
      this.countryNameAbbr = "PER";
      this.countryCode = '51';
      this.regex = /^(?:(?:\+|)51|)(?:0|)(?:(?:1\d{7})|(?:9\d{8})|(?:(?:4[1234]|5[12346]|6[1234567]|7[2346]|8[234])\d{6}))$/;
      this.optionalTrunkPrefix = '0';
      this.nationalNumberSeparator = ' ';
      this.nationalDestinationCode = ['1', '9', '41', '42', '43', '44', '51', '52', '53', '54', '56', '61', '62', '63', '64', '65', '66', '67', '72', '73', '74', '76', '82', '83', '84'];
    }

    Peru.prototype.specialRules = function(withoutCountryCode, withoutNDC, ndc) {
      var phone;
      phone = new vtex.phone.PhoneNumber(this.countryCode, '', withoutNDC);
      if (ndc === '1' && withoutNDC.length === 7) {
        return phone;
      } else if (ndc === '9' && withoutNDC.length === 8) {
        phone.isMobile = true;
        phone.nationalDestinationCode = '';
        phone.number = withoutCountryCode;
        return phone;
      } else if (ndc.length === 2 && withoutNDC.length === 6) {
        return phone;
      }
    };

    Peru.prototype.splitNumber = function(number) {
      if (number.length === 6) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{3})/));
      } else if (number.length === 7) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{4})/));
      } else if (number.length === 9) {
        return vtex.phone.compact(number.split(/(\d{3})(\d{3})(\d{3})/));
      }
      return [number];
    };

    return Peru;

  })();

  root.vtex.phone.countries = root.vtex.phone.countries || {};

  root.vtex.phone.countries['51'] = new Peru();

}).call(this);
