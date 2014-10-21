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
