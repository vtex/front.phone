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
