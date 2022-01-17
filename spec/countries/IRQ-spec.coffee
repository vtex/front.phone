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
        
        it  'mobile number', ->
            #Arrange
            number = "+964 751 1234567"
            result = Phone.getPhoneInternational(number)
            expect(result.valid).to.be.true
            expect(result.isMobile).to.be.true




