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
