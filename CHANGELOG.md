# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.18.0-beta] - 2023-05-24

### Changed
- NZL phone format and validation.

## [4.17.12-beta] - 2023-04-12

### Fixed
- Phone rules to accept slash when entering a number

## [4.17.9] - 2023-03-10

### Fixed
- Australia ('AUS') country rules to keep front 0 when saving.

## [4.17.8] - 2023-03-01

### Fixed
- Australia ('AUS') country rules to accept front 0 and more digits.

## [4.17.7] - 2023-01-26

### Fixed

- List of NDCs for MEX to include new area code 479.
- List of NDCs for ARG to include new area code 2634.

## [4.17.6] - 2023-01-06

### Fixed
- Romania ('ROU') country rules to remove extra characters.

## [4.17.5] - 2022-12-06

### Fixed
- Mexico ('MEX') country rules to add ndc 446.

### Added
- Romania ('ROU'), Saudi Arabia ('SAU'), United Arab Emirates ('ARE') and Greece ('GRC') country rules.

## [4.17.4] - 2022-10-19

### Fixed
- France ('FRA') country rules to save numbers with only one preceding zero.

## [4.17.3] - 2022-08-17

### Fixed
- France ('FRA') country rules to remove extra zero before mobile numbers.

## [4.17.2] - 2022-07-26

## [4.17.1] - 2022-07-26

## [4.17.1] - 2022-07-26
### Added
- Australia ('AUS') and New Zealand ('NZL') phone rules.

## [4.17.0] - 2022-07-20
### Added
- Indonesia ('IDN'), Czech Republic ('CZE') and Slovakia ('SVK') phone rules.

## [4.16.0] - 2022-05-26
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


[Unreleased]: https://github.com/vtex/front.phone/compare/v4.17.12-beta...HEAD
[4.15.1]: https://github.com/vtex/front.phone/compare/v4.15.0...v4.15.1

[4.17.10]: https://github.com/vtex/front.phone/compare/v4.17.9...v4.17.10
[4.17.9]: https://github.com/vtex/front.phone/compare/v4.17.8...v4.17.9
[4.17.8]: https://github.com/vtex/front.phone/compare/v4.17.7...v4.17.8
[4.17.7]: https://github.com/vtex/front.phone/compare/v4.17.6...v4.17.7
[4.17.6]: https://github.com/vtex/front.phone/compare/v4.17.5...v4.17.6
[4.17.5]: https://github.com/vtex/front.phone/compare/v4.17.4...v4.17.5
[4.17.4]: https://github.com/vtex/front.phone/compare/v4.17.3...v4.17.4
[4.17.3]: https://github.com/vtex/front.phone/compare/v4.17.2...v4.17.3
[4.17.2]: https://github.com/vtex/front.phone/compare/v4.17.1...v4.17.2
[4.17.1]: https://github.com/vtex/front.phone/compare/v4.17.0...v4.17.1
[4.17.1]: https://github.com/vtex/front.phone/compare/v4.17.0...v4.17.1
[4.17.0]: https://github.com/vtex/front.phone/compare/v4.16.0...v4.17.0
[4.16.0]: https://github.com/vtex/front.phone/compare/v4.15.15-beta...v4.16.0
[4.17.12-beta]: https://github.com/vtex/front.phone/compare/v4.17.11-beta...v4.17.12-beta