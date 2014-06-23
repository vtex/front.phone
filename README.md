# front.phone

front.phone is a Javascript library that validates, formats and identifies phone numbers. The main goal of this project is to create a trustful component to input phone numbers and extract information from it. We can currently extract the phone's country code, national destination number, it's number and in some cases if it is a mobile number. The recommended input for it's use is in international notation. 

We are compliant to the [E.123](http://en.wikipedia.org/wiki/E.123) notation.

## Installing

Depending on you application scope, you may want or not to use all countries available in this library. You can follow this rule:

- All countries: `vtex-phone-bundle.min.js`
- Just some countries: `vtex-phone.min.js` + `usa.js` + `brazil.js` + etc

front.phone checks phone countries files included, so if you include a new country file, it will recognize and validate as expected.

There's also an Angular.js filter: `vtex-phone-filter.min.js`. (The bundle does not include the filter).

## Usage

### Getting Phone's Info

This functions extracts info from a number in international or national notation and *also* validate. You can pass the country code and national destination number (in this order) as a param, if you already know them.

```javascript
// you can relax about usage of hiphens and other special characters, we'll strip 
//it down internally later ;)
var number = "5521989898989";
var phone = vtex.phone.getPhoneInternational(number); 
console.log(phone); // { countryCode: "55", nationalDestinationCode: "21", 
//number: "998986565", isMobile: true, isValid: true }
```

```javascript
var number = "5521989898989";
var phone = vtex.phone.getPhoneNational(number, "55"); // if you use this function,
//you MUST give the phone's countryCode
console.log(phone); // { countryCode: "55", nationalDestinationCode: "21",
//number: "998986565", isMobile: true, isValid: true }
```

### Validation

This function is a bit different from the above function, it's a bit faster and uses only a big regex to validate the number, returning `true` or `false`.

```javascript
// Given a phone number in international notation
var number = "+552189898989";
var result = vtex.phone.validate(number);
console.log(result); // true
```

If you already know the phone's country code you may include in a new param.

```javascript
// Given a phone number in international notation
var number = "+552189898989";
var result = vtex.phone.validate(number, "55");
console.log(result); // true
```

### Formatting

For the use of this function you need first to get the phone's info. You can get formatted in three different notations: international, national or local. Remember that all of them follows [E.123](http://en.wikipedia.org/wiki/E.123).

```javascript
var number = "552189898989";
var phone = vtex.phone.getPhoneInternational(number); 
var result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL);
console.log(result); // +55 21 8989 8989
```

```javascript
var number = "552189898989";
var phone = vtex.phone.getPhoneInternational(number); 
var result = vtex.phone.format(phone, vtex.phone.NATIONAL);
console.log(result); // (21) 8989-8989
```

```javascript
var number = "552189898989";
var phone = vtex.phone.getPhoneInternational(number); 
var result = vtex.phone.format(phone, vtex.phone.LOCAL);
console.log(result); // 8989-8989
```

### Angular Filter

1. Include `vtex-phone-filter.min.js`.

2. Add `"vtex-phoneFilter"` as a dependency to your app.

3. Use the filter like this:

   ```
   {{ user.phoneNumber | phone }}
   or
   {{ '552189898989' | phone }}
   ```

   Which will give you the following output:

   ```
   +55 21 8989 8989
   ```

## Contributing

Anyone is welcome to contribute to this project.
We now are urging for pull requests of new countries' phones, aiming to global domination.
But before you do, please read the [guidelines for contributing](CONTRIBUTING.md).

## Author

* [@brenoc](https://github.com/brenoc)

## License

Copyright 2013 VTEX

Licensed under the MIT License
