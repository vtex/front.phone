# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Fixed
- ITA phone number testing.

## [4.15.13-beta] - 2022-05-19
### Fixed
- ITA phone number testing.

## [4.15.12-beta] - 2022-05-19
### Added
- ITA phone number testing.

## [4.15.11-beta] - 2022-05-19
### Fixed
- Issue in RegEx due to 39 being the country code and also being allowed as part of the NDCs.

## [4.15.10-beta] - 2022-05-19
### Fixed
- Reinserted minimum splitNumber code to check if it is causing issues.

## [4.15.9-beta] - 2022-05-19
### Fixed
- Removed splitNumber code to check if it is causing Italy phone rules regex not being used.

## [4.15.8-beta] - 2022-05-18

## [4.15.7-beta] - 2022-05-18

## [4.15.6-beta] - 2022-05-18

## [4.15.5-beta] - 2022-05-18
### Fixed
- Italy phone rules regex not being used when a phone number is entered without the country code.

## [4.15.4-beta] - 2022-05-17
### Fixed
- Stricter Italy phone rules.

## [4.15.3-beta] - 2022-05-17
### Added
- Italy phone rules.

## [4.15.2] - 2022-05-05
### Fixed
- Regex for NANP to include the Dominican Republic area codes.

## [4.15.1] - 2022-03-25 [YANKED]

### Added
- Dominican Republic phone number rules ('DOM', 'NANP')

## [4.15.0] - 2022-02-23
### Changed
- Update deploy pipeline to use Jenkins.

## [4.14.0] - 2022-02-17

### Added

- India phone rules.

### Fixed

- Iraq phone rules.

## [4.13.1] - 2022-02-09

### Fixed

- Singapore phone rules.
- Colombia number validation test.

## [4.13.0] - 2022-01-28

## [4.12.0] - 2022-01-28

### Added

- Singapore configuration.

## [4.11.0] - 2022-01-19

### Added

- Iraq configuration.

## [4.10.8] - 2021-10-25
### Fixed
- Regex for NDC 2336 in Argentinian configuration.

## [4.10.7] - 2021-10-05
### Added
- National destination code '2336' into ARG file.

## [4.10.6] - 2021-10-05

- Add '663' into MEX file

## [4.10.5] - 2021-08-31

- Add North American Numbering Plan for National Destination Code

## [4.10.4] - 2021-07-27
### Fixed
- Validation for VEN national destination code "424".

## [4.10.3] - 2021-07-26

- Add '424' code into VEN file

## [4.10.2] - 2021-03-03

- Add phone code '2984' into ARG file

## [4.10.1] - 2020-08-03

- Updates NDC and validation regex for NANP territories.

## [4.10.0] - 2020-07-21

- Fix Mexico regex

## [4.9.0] - 2020-06-10

- New country! Welcome, American Samoa!
- New country! Welcome, Guam!
- New country! Welcome, Northern Mariana Islands!
- New country! Welcome, Puerto Rico!
- New country! Welcome, U.S. Virgin Islands!

## [4.8.4] - 2020-05-13

- Fix missing USA state (346 Texas)

## 4.8.3

- Revert Panama regex

## 4.8.2

- Fix npm build

## 4.8.1

- Add new Mexico NDI 56

## 4.8.0

- New country! Welcome, France!

## 4.7.3

- New country! Welcome, Korea!

## 4.7.2

- Fix Panama regex

## 4.7.1

- Fix GBR regex

## 4.7.0

- New country! Welcome, Panama!

## 4.6.0

- New country! Welcome, Costa Rica!

## 4.5.1

- Fix formatting of Spanish and Venezuelian phone numbers

## 4.5.0

- New country! Welcome, Venezuela!

## 4.4.2

- Fix false-positive validations

## 4.4.1

- Add Spain to build of all countries

## 4.4.0

- New country! Welcome, Spain!

## 4.3.15

- Add missing paraguayan mobile NDCs

## 4.3.14

- Add missing paraguayan NDC

## 4.3.13

- Remove console.log

## 4.3.12

- Add missing Bolivian phone number validation

## 4.3.11

- Update Brazilian ninth digit

## 4.3.10

- Add missing national destination codes of USA

## 4.3.9

- Update brazilian ninth digit

## 4.3.8

- Fix Guatemala's format function

## 4.3.7

- Travis deploying! :tada:

## 4.3.4, 4.3.5, 4.3.6

- Series of releases trying to setup Travis to deploy :disappointed:

## 4.3.3

- Fix chilean regex
- Fix angular version in `package.json`, so tests pass
- Stop setting prepublish script

## 4.3.2

- Fix `getCountryCodeByNameAbbr` when `countryNameAbbr` is an array, like [NANP](https://github.com/vtex/front.phone/blob/922aa44076cf860ad5d8d7161dabfa7b64d9319b/src/script/countries/NANP.coffee#L12)

## 4.3.1

- Fix Mexico's validation for phones with national destination code starting with 42

## 4.3.0

- New country! Welcome, Bolivia!

## 4.2.2

- Fix brazilian validation regex

## 4.2.1

- Update brazilian phones with the ninth digit

## 4.2.0

- New country! Welcome, Canada!
- Add more phone info to the resulting object, now it includes `countryNameAbbr` (eg: USA, CAN). That is useful for same cases like phones from NANP.

## 4.1.0

- New country! Welcome, Guatemala!
- Fix .gitignore

## 4.0.0

Breaking Changes:

- Remove Bower support
- Remove compiled files from git
- Use CommonJS

The project is now available on npm, so you may now use it with Webpack and React.

## 3.9.2

- Fix brazilian regex

## 3.9.1

- Update brazilian nine digits mobile phone numbers range according to the national change plan

## 3.9.0

- Change project folder structure

## 3.8.4

- Fix brazilian nine digits numbers

## 3.8.3

- Fix dist files comments
- Remove version from bower.json
- Remove package.json from bower's ignore

## 3.8.2

- Fix peruvian phones

## 3.8.1

- Bug fixes

## 3.8.0

- New country! Welcome, UK!
- Fix paraguayan phones
- Add Travis

## 3.7.0

- New country! Welcome, Mexico!

## 3.6.0

- Fix README.md
- Fix Contribution guidelines
- Clean up build process

## 3.5.0

- Extend phone filter to add parameters

## 3.4.0

- Add AngularJS filter

## 3.3.0

- New country! Welcome, Paraguay
- Improve Brazil's regex


[Unreleased]: https://github.com/front.phone//compare/v4.15.13-beta...HEAD
[4.15.1]: https://github.com/vtex/front.phone/compare/v4.15.0...v4.15.1

[4.15.13-beta]: https://github.com/front.phone//compare/v4.15.12-beta...v4.15.13-beta
[4.15.12-beta]: https://github.com/front.phone//compare/v4.15.11-beta...v4.15.12-beta
[4.15.11-beta]: https://github.com/front.phone//compare/v4.15.10-beta...v4.15.11-beta
[4.15.10-beta]: https://github.com/front.phone//compare/v4.15.9-beta...v4.15.10-beta
[4.15.9-beta]: https://github.com/front.phone//compare/v4.15.8-beta...v4.15.9-beta
[4.15.8-beta]: https://github.com/front.phone//compare/v4.15.7-beta...v4.15.8-beta
[4.15.7-beta]: https://github.com/front.phone//compare/v4.15.6-beta...v4.15.7-beta
[4.15.6-beta]: https://github.com/front.phone//compare/v4.15.5-beta...v4.15.6-beta
[4.15.5-beta]: https://github.com/front.phone//compare/v4.15.4-beta...v4.15.5-beta
[4.15.4-beta]: https://github.com/front.phone//compare/v4.15.3-beta...v4.15.4-beta
[4.15.3-beta]: https://github.com/front.phone//compare/v4.15.2...v4.15.3-beta