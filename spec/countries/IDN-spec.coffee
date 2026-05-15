expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/IDN')

describe 'Indonesia', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+62 2134567890"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('IDN')

        it  'mobile number', ->
            number = "+62 81348567890"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "623618496655"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+62 361 849 6655/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "12345678"

            # Act
            result = Phone.countries['62'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(2)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+62 749 12345"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+62 11 123"

            # Act
            result = Phone.validate(number, '62')

            # Assert
            expect(result).to.be.false

    describe 'Branch coverage', ->

        it 'leaves isMobile unset for a 2-digit NDC starting with 8', ->
            # Arrange (NDC '84' is not 3-digit, hits the else)
            result = Phone.countries['62'].specialRules('8412345678', '12345678', '84')

            # Assert
            expect(!!result.isMobile).to.be.false

        it 'splits 5-digit numbers', ->
            # Act
            result = Phone.countries['62'].splitNumber('12345')

            # Assert
            expect(result.length).to.equal(2)

        it 'splits 6-digit numbers', ->
            # Act
            result = Phone.countries['62'].splitNumber('123456')

            # Assert
            expect(result.length).to.equal(2)

        it 'splits 7-digit numbers', ->
            # Act
            result = Phone.countries['62'].splitNumber('1234567')

            # Assert
            expect(result.length).to.equal(2)

        it 'returns the input wrapped in an array when length is unsupported', ->
            # Act
            result = Phone.countries['62'].splitNumber('123')

            # Assert
            expect(result).to.deep.equal(['123'])
