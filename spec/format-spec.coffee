describe 'Should format a number', ->

	phone = {}

	beforeEach ->
		# Arrange
		number = "552198986565"
		phone = vtex.phone.validateInternational(number)

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
		phone = vtex.phone.validateInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL)

		# Assert
		expect(result).toMatch(/\+57 301 987 9654/)

	it 'in national format mobile from Colombia', ->
		# Arrange
		number = "573019879654"
		phone = vtex.phone.validateInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/301 987 9654/)
	
	it 'in international format mobile from Argentina', ->
		# Arrange
		number = "5491198986565"
		phone = vtex.phone.validateInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.INTERNATIONAL)

		# Assert
		expect(result).toMatch(/\+54 9 11 9898 6565/)

	it 'in national format mobile from Argetina', ->
		# Arrange
		number = "54111598986565"
		phone = vtex.phone.validateInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/\(11\) 15 9898\-6565/)

	it 'in national format mobile from Chile', ->
		# Arrange
		number = "56998986565"
		phone = vtex.phone.validateInternational(number)

		# Act
		result = vtex.phone.format(phone, vtex.phone.NATIONAL)

		# Assert
		expect(result).toMatch(/9 9898 6565/)
