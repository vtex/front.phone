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
            number = "+62 82348567890"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "6203618496655"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+62 361 8496655/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "1234567890"

            # Act
            result = Phone.countries['62'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+62 751 123456"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+62 234 123"

            # Act
            result = Phone.validate(number, '62')

            # Assert
            expect(result).to.be.false



