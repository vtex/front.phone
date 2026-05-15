expect = require('chai').expect
Phone = require('../../src/script/Phone')
unitedarabemirates  = require('../../src/script/countries/ARE')

describe 'United Arab Emirates', ->

    describe 'Should get a', ->

        it 'landline number', ->
            # Arrange
            number = "+971 050 444400"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result.valid).to.be.true
            expect(result.countryNameAbbr).to.equal('ARE')

        it  '9-digit mobile number', ->
            number = "+971 055 646 528"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true 

    describe 'Should format a number', ->

        it 'in international format', ->
            # Arrange
            number = "9710554440400"
            phone = Phone.getPhoneInternational(number)

            # Act
            result = Phone.format(phone, Phone.INTERNATIONAL)

            # Assert
            expect(result).to.match(/\+971 055 4440400/)

    describe 'Should split', ->

        it 'number', ->
            # Arrange
            number = "097001234"

            # Act
            result = Phone.countries['971'].splitNumber(number)

            # Assert
            expect(result.length).to.equal(3)

    describe 'Should not', ->

        it 'get an invalid number', ->
            # Arrange
            number = "+971 8 700 1234"

            # Act
            result = Phone.getPhoneInternational(number)

            # Assert
            expect(result).to.be.null

        it 'validate an invalid number', ->
            # Arrange
            number = "+971 666 7564 6528"

            # Act
            result = Phone.validate(number, '971')

            # Assert
            expect(result).to.be.false

    describe 'Branch coverage', ->

        it 'flags isMobile=true when the NDC has 3 digits', ->
            # Act
            result = Phone.countries['971'].specialRules('050444400', '444400', '050')

            # Assert
            expect(result.isMobile).to.be.true

        it 'flags isMobile=true when the NDC starts with 5', ->
            # Act
            result = Phone.countries['971'].specialRules('51234567', '1234567', '5')

            # Assert
            expect(result.isMobile).to.be.true

        it 'returns undefined when the NDC is neither 3-digit nor starts with 5', ->
            # Act
            result = Phone.countries['971'].specialRules('21234567', '1234567', '2')

            # Assert
            expect(result).to.be.undefined

        it 'splits a 10-digit number', ->
            # Act
            result = Phone.countries['971'].splitNumber('1234567890')

            # Assert
            expect(result.length).to.equal(3)

        it 'returns the input wrapped in an array when length is unsupported', ->
            # Act
            result = Phone.countries['971'].splitNumber('123')

            # Assert
            expect(result).to.deep.equal(['123'])
