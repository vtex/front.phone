# front.phone

[![Build Status](https://travis-ci.org/vtex/front.phone.svg?branch=master)](https://travis-ci.org/vtex/front.phone)

front.phone is a Javascript library that identifies, validates and formats phone numbers.

**[Demo](https://vtex.github.io/front.phone/)**

The main goal of this project is to create a trustful component to input phone numbers and extract information from it. We can currently extract the phone's country code, national destination number, it's number and in some cases if it is a mobile number. The recommended input for it's use is in international notation.

We are compliant to the [E.123](http://en.wikipedia.org/wiki/E.123) notation.

## Countries

We currently cover [these countries](src/script/countries/).

Didn't find your own? Feel free to [contribute](#contributing)!

## Usage

### Getting Phone's Info

This functions extracts info from a number in international or national notation and *also* validate. You can pass the country code and national destination number (in this order) as a param, if you already know them.

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

// you can relax about usage of hiphens and other special characters, we'll strip 
//it down internally later ;)
var number = "5521989898989";
var phone = Phone.getPhoneInternational(number);
console.log(phone); // { countryCode: "55", nationalDestinationCode: "21", 
//number: "998986565", isMobile: true, isValid: true }
```

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

var number = "5521989898989";
var phone = Phone.getPhoneNational(number, "55"); // if you use this function,
//you MUST give the phone's countryCode
console.log(phone); // { countryCode: "55", nationalDestinationCode: "21",
//number: "998986565", isMobile: true, isValid: true }
```

### Validation

This function is a bit different from the above function, it's a bit faster and uses only a big regex to validate the number, returning `true` or `false`.

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

// Given a phone number in international notation
var number = "+552189898989";
var result = Phone.validate(number);
console.log(result); // true
```

If you already know the phone's country code you may include in a new param.

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

// Given a phone number in international notation
var number = "+552189898989";
var result = Phone.validate(number, "55");
console.log(result); // true
```

### Formatting

For the use of this function you need first to get the phone's info. You can get formatted in three different notations: international, national or local. Remember that all of them follows [E.123](http://en.wikipedia.org/wiki/E.123).

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

var number = "552189898989";
var phone = Phone.getPhoneInternational(number);
var result = Phone.format(phone, Phone.INTERNATIONAL);
console.log(result); // +55 21 8989 8989
```

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

var number = "552189898989";
var phone = Phone.getPhoneInternational(number);
var result = Phone.format(phone, Phone.NATIONAL);
console.log(result); // (21) 8989-8989
```

```javascript
var Phone = require("@vtex/phone");
var brazil = require("@vtex/phone/countries/BRA");

var number = "552189898989";
var phone = Phone.getPhoneInternational(number);
var result = Phone.format(phone, Phone.LOCAL);
console.log(result); // 8989-8989
```

### Angular Filter

Use the filter like this:

   ```
   {{ user.phoneNumber | phone }}
   or
   {{ '552189898989' | phone }}
   ->
   +55 21 8989 8989
   ```

It also has two optional parameters:

* the format to be converted. One of  **`'international'`**, `'national'`, `'local'`.
* the national number, if needed. It's blank by default.

```
{{ '2189898989' | phone:'international':55 }}
->
+55 21 8989 8989
```


## Building and Testing

We use Grunt as a task runner. Before you start, make sure to `npm install -g grunt-cli` and `npm install`.

Use `grunt` to build and test, and rebuild whenever a file is changed. 

Use `grunt dist` to build, test and prepare files to npm.

## Contributing

Anyone is welcome to contribute to this project.
We now are urging for pull requests of new countries' phones.
But before you do, please read the [guidelines for contributing](CONTRIBUTING.md).

## License

Licensed under the MIT License
