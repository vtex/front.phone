expect = require('chai').expect
Phone = require('../../src/script/Phone')
singapore  = require('../../src/script/countries/SGP')

describe 'Singapore', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+65 12345678"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('SGP')

         it 'landline number', ->
            # Arrange
            number = "+65 123456789123"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('SGP')    

        it  'mobile number starting with 8', ->
            number = "+65 81234567"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

        it 'mobile number starting with 9', ->
            number = "+65 91234567"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "6512345678"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+65 1234 5678/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "12345678"

            # Act
            result = Phone.countries['65'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(2)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+65 1234567"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null
        
        it 'get an invalid number with letters', ->
            # Arrange
            number = "+65 1sss234567"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null




