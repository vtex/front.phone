describe 'Should format a number', ->

	phone = {}

	beforeEach ->
		# Arrange
		number = "552198986565"
		phone = vtex.phone.getPhoneInternational(number)

	it 'in international format', ->
		# Act
		result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL)

		# Assert
		expect(result).toMatch(/\+55 21 9898 6565/)

	it 'in national format', ->
		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/\(21\) 9898\-6565/)

	it 'in local format', ->
		# Act
		result = vtex.phone.format(phone, vtex.phone.LOCAL)

		# Assert
		expect(result).toMatch(/9898\-6565/)

	it 'in international format mobile from Colombia', ->
		# Arrange
		number = "573019879654"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL)

		# Assert
		expect(result).toMatch(/\+57 301 987 9654/)

	it 'in national format from Colombia', ->
		# Arrange
		number = "5729898565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/\(2\) 989 8565/)

	it 'in national format mobile from Colombia', ->
		# Arrange
		number = "573019879654"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/301 987 9654/)
	
	it 'in international format mobile from Argentina', ->
		# Arrange
		number = "5491198986565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL)

		# Assert
		expect(result).toMatch(/\+54 9 11 9898 6565/)

	it 'in national format mobile from Argetina', ->
		# Arrange
		number = "54111598986565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/\(11\) 15 9898\-6565/)

	it 'in national format mobile from Chile', ->
		# Arrange
		number = "56998986565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/9 9898 6565/)

	it 'in national format metropolitan area phone from Peru', ->
		# Arrange
		number = "5118786565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/878 6565/)

	it 'in national format phone from Peru', ->
		# Arrange
		number = "5141786565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/786 565/)

	it 'in national fomat mobile phone from Peru', ->
		# Arrange
		number = "51987876565"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/987 876 565/)

	it 'in national format from Paraguay', ->
		# Arrange
		number = "595219878765"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/\(21\) 987 8765/)

	it 'in national format from Paraguay with 6 digits', ->
		# Arrange
		number = "59521505270"
		phone = vtex.phone.getPhoneInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/\(21\) 505 270/)

