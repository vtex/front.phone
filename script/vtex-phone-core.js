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
      var countryCode, countryObj, _ref;
      if (number === null) {
        return false;
      }
      number = this.normalize(number);
      if (givenCountryCode) {
        return vtex.phone.countries[givenCountryCode].regex.test(number);
      } else {
        _ref = vtex.phone.countries;
        for (countryCode in _ref) {
          countryObj = _ref[countryCode];
          if (countryObj.regex.test(number)) {
            return true;
          }
        }
        return false;
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
