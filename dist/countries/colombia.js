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
