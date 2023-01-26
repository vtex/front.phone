expect = require('chai').expect
Phone = require('../../src/script/Phone')
romania  = require('../../src/script/countries/ROU')

describe 'Romania', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+40 12345678"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('ROU')

         it 'landline number', ->
            # Arrange
            number = "+40 0213 456 789"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('ROU')    

        it  'mobile number starting with 6', ->
            number = "+40 670 336 766"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

        it 'mobile number starting with 7', ->
            number = "+40 770 336 766"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "40770336766"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+40 770 336 766/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "770336766"

            # Act
            result = Phone.countries['40'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "7 336 776"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null