expect = require('chai').expect
Phone = require('../../src/script/Phone')
saudiarabia  = require('../../src/script/countries/SAU')

describe 'Saudi Arabia', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+966 017 725225"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('SAU')

        it  '9-digit mobile number', ->
            number = "+966 050 646 528"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "966055444400"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+966 055 444400/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "920001950"

            # Act
            result = Phone.countries['966'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+966 8 700 1234"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+966 676 5646 6528"

            # Act
            result = Phone.validate(number, '966')

            # Assert
            expect(result).to.be.false
