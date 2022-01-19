expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/IRQ')

describe 'Iraq', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+964 66 1234567"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('IRQ')
        
        it 'landline number with 6 digits', ->
            # Arrange
            number = "+964 66 123456"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('IRQ')
        
        it 'landline number with 1 digit area code', ->
            # Arrange
            number = "+964 1 1234567"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('IRQ')

        it  'mobile number', ->
            number = "+964 751 1234567"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

        it 'mobile number with optional prefix', ->
            number = "+964 0751 1234567"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "964661234567"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+964 66 123 4567/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "1234567"

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



