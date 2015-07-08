expect = require('chai').expect
Phone = require('./helpers/require-all')

describe 'Should format a number', ->

	phone = {}

	beforeEach ->
		# Arrange
		number = "552198986565"
		phone = Phone.getPhoneInternational(number)

	it 'in international format', ->
		# Act
		result = Phone.format(phone, Phone.INTERNATIONAL)

		# Assert
		expect(result).to.match(/\+55 21 9898 6565/)

	it 'in national format', ->
		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/\(21\) 9898\-6565/)

	it 'in local format', ->
		# Act
		result = Phone.format(phone, Phone.LOCAL)

		# Assert
		expect(result).to.match(/9898\-6565/)

	it 'in international format mobile from Colombia', ->
		# Arrange
		number = "573019879654"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.INTERNATIONAL)

		# Assert
		expect(result).to.match(/\+57 301 987 9654/)

	it 'in national format from Colombia', ->
		# Arrange
		number = "5729898565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/\(2\) 989 8565/)

	it 'in national format mobile from Colombia', ->
		# Arrange
		number = "573019879654"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/301 987 9654/)

	it 'in international format mobile from Argentina', ->
		# Arrange
		number = "5491198986565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.INTERNATIONAL)

		# Assert
		expect(result).to.match(/\+54 9 11 9898 6565/)

	it 'in national format mobile from Argetina', ->
		# Arrange
		number = "54111598986565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/\(11\) 15 9898\-6565/)

	it 'in national format mobile from Chile', ->
		# Arrange
		number = "56998986565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/9 9898 6565/)

	it 'in national format metropolitan area phone from Peru', ->
		# Arrange
		number = "5118786565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/878 6565/)

	it 'in national format phone from Peru', ->
		# Arrange
		number = "5141786565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/786 565/)

	it 'in national fomat mobile phone from Peru', ->
		# Arrange
		number = "51987876565"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/987 876 565/)

	it 'in national format from Paraguay', ->
		# Arrange
		number = "595219878765"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/\(21\) 987 8765/)

	it 'in national format from Paraguay with 6 digits', ->
		# Arrange
		number = "59521505270"
		phone = Phone.getPhoneInternational(number)

		# Act
		result = Phone.format(phone, Phone.NATIONAL)

		# Assert
		expect(result).to.match(/\(21\) 505 270/)

