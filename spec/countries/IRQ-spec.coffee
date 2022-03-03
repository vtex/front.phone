expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/IRQ')

describe 'Iraq', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "964 1234567890"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('IRQ')

        it  'mobile number', ->
            number = "964 1234567890"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "9646612345678"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+964 66123 45678/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "1234567890"

            # Act
            result = Phone.countries['964'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(2)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+964 751 123456"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+964 234 123"

            # Act
            result = Phone.validate(number, '964')

            # Assert
            expect(result).to.be.false



