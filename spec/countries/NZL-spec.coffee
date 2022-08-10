expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/NZL')

describe 'New Zealand', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+64 9 700 1234"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('NZL')

        it  '8-digit mobile number', ->
            number = "+64 21 883 747"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

        it  '9-digit mobile number', ->
            number = "+64 27 564 6528"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

        it  '10-digit mobile number', ->
            number = "+64 210 248 3336"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "642102483336"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+64 2 10 248 3336/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "97001234"

            # Act
            result = Phone.countries['64'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+64 8 700 1234"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+64 6 7564 6528"

            # Act
            result = Phone.validate(number, '64')

            # Assert
            expect(result).to.be.false
