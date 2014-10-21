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
