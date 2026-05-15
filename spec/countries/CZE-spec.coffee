expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/CZE')

describe 'Czech Republic', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+420 321 427 000"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('CZE')

        it  'mobile number', ->
            number = "+420 720 222 124"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "420720222124"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+420 720 222124/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "123456789"

            # Act
            result = Phone.countries['420'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+420 521 123456"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+420 234 1237"

            # Act
            result = Phone.validate(number, '420')

            # Assert
            expect(result).to.be.false

    describe 'Branch coverage', ->

        it 'matches an 8-digit number with the 1-digit NDC "2"', ->
            # Act
            result = Phone.countries['420'].specialRules('212345678', '12345678', '2')

            # Assert
            expect(result).to.exist
            expect(result.number).to.equal('12345678')

        it 'matches a 7-digit number with a 2-digit NDC', ->
            # Act
            result = Phone.countries['420'].specialRules('311234567', '1234567', '31')

            # Assert
            expect(result).to.exist
            expect(result.number).to.equal('1234567')

        it 'flags a 6-digit mobile number with a 3-digit NDC starting with 6', ->
            # Act
            result = Phone.countries['420'].specialRules('601123456', '123456', '601')

            # Assert
            expect(result.isMobile).to.be.true

        it 'flags a 6-digit mobile number with a 3-digit NDC starting with 7', ->
            # Act
            result = Phone.countries['420'].specialRules('720123456', '123456', '720')

            # Assert
            expect(result.isMobile).to.be.true

        it 'returns undefined when the lengths do not match any branch', ->
            # Act
            result = Phone.countries['420'].specialRules('212345', '12345', '2')

            # Assert
            expect(result).to.be.undefined

        it 'returns the input wrapped in an array when splitNumber length is unsupported', ->
            # Act
            result = Phone.countries['420'].splitNumber('123')

            # Assert
            expect(result).to.deep.equal(['123'])
