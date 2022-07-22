expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/AUS')

describe 'Australia', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+61 3 9481 7090"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('AUS')

        it  'mobile number', ->
            number = "+61 4 0098 8691"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "61298789402"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+61 2 9878 9402/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "123456789"

            # Act
            result = Phone.countries['61'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+61 4 00988 8693"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+61 2 234 1234"

            # Act
            result = Phone.validate(number, '61')

            # Assert
            expect(result).to.be.false
