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
      this.regex = /^(?:(?:(?:\+|)(?:55|)|))(?:0|)(?:(?:(?:11|12|13|14|15|16|17|18|19|21|22|24|27|28)(?:9\d{8}|\d{8}))|(?:(?:11|12|13|14|15|16|17|18|19|21|22|24|27|28|31|32|33|34|35|36|37|38|41|42|43|44|45|46|47|48|49|51|52|53|54|55|61|62|63|64|65|66|67|68|69|71|72|73|74|75|77|78|79|81|82|83|84|85|86|87|88|89|91|92|93|94|95|96|97|98|99)\d{8}))$/;
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
