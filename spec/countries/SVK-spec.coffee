expect = require('chai').expect
Phone = require('../../src/script/Phone')
iraq  = require('../../src/script/countries/SVK')

describe 'Slovakia', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+421 313 456 789"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('SVK')

        it  'mobile number', ->
            number = "+421 923 456 789"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "421923456789"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+421 923 456789/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "123456789"

            # Act
            result = Phone.countries['421'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+421 751 123456"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+421 334 1234"

            # Act
            result = Phone.validate(number, '421')

            # Assert
            expect(result).to.be.false

    describe 'Branch coverage', ->

        it 'matches an 8-digit number with the 1-digit NDC "2"', ->
            # Act
            result = Phone.countries['421'].specialRules('212345678', '12345678', '2')

            # Assert
            expect(result).to.exist
            expect(result.number).to.equal('12345678')

        it 'matches a 7-digit number with a 2-digit NDC', ->
            # Act
            result = Phone.countries['421'].specialRules('311234567', '1234567', '31')

            # Assert
            expect(result).to.exist
            expect(result.number).to.equal('1234567')

        it 'flags a 6-digit mobile number with a 3-digit NDC starting with 9', ->
            # Act
            result = Phone.countries['421'].specialRules('901123456', '123456', '901')

            # Assert
            expect(result.isMobile).to.be.true

        it 'returns undefined when the lengths do not match any branch', ->
            # Act
            result = Phone.countries['421'].specialRules('212345', '12345', '2')

            # Assert
            expect(result).to.be.undefined

        it 'returns the input wrapped in an array when splitNumber length is unsupported', ->
            # Act
            result = Phone.countries['421'].splitNumber('123')

            # Assert
            expect(result).to.deep.equal(['123'])
