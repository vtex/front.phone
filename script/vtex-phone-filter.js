(function() {
  angular.module('vtex.phoneFilter', []).filter('phone', function() {
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

}).call(this);
