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

    describe 'Should format', ->

        it 'a number in international format', ->
            # Arrange
            number = "61298789402"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\(02\) 9878 9402/)

        it 'a mobile number in international format', ->
            # Arrange
            number = "+610498789402"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/0498 789 402/)
        
        it 'a mobile number in national format', ->
            # Arrange
            number = "0411884057"
            phone = Phone.getPhoneNational(number, '61', '4')

            # Act
            result = Phone.format(phone, Phone.NATIONAL)

            # Assert
            expect(result).to.match(/0411 884 057/)

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
            number = "+61 6 2288 8693"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+61 2 22234 12340"

            # Act
            result = Phone.validate(number, '61')

            # Assert
            expect(result).to.be.false
