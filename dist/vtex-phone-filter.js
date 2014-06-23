(function() {
  angular.module('vtex.phoneFilter', []).filter('phone', function() {
    return function(ph) {
      var phoneObject;
      if (!ph) {
        return 'N/A';
      }
      phoneObject = vtex.phone.getPhoneInternational(ph);
      return vtex.phone.format(phoneObject, vtex.phone.INTERNATIONAL);
    };
  });

}).call(this);
