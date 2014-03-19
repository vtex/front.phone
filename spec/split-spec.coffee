describe 'Should split', ->

	describe 'a brazilian', ->

		it 'number with 8 digits', ->
			# Arrange
			number = "98986565"

			# Act
			result = vtex.phone.countries['55'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

		it 'number with 9 digits only if it\'s mobile', ->
			# Arrange
			numberMobile = "998986565"
			numberNotValid = "398986565"

			# Act
			resultMobile = vtex.phone.countries['55'].splitNumber(numberMobile)
			resultNotValid = vtex.phone.countries['55'].splitNumber(numberNotValid)

			# Assert
			expect(resultMobile.length).toBe(2)
			expect(resultNotValid.length).toBe(1)

	describe 'an argentinian', ->

		describe 'land line number', ->

			number = ''

			afterEach ->
				# Act
				result = vtex.phone.countries['54'].splitNumber(number)

				# Assert
				expect(result.length).toBe(2)

			it 'with 8 digits', ->
				# Arrange
				number = "98986565"

			it 'with 7 digits', ->
				# Arrange
				number = "8986565"

			it 'with 6 digits', ->
				# Arrange
				number = "986565"

	describe 'an uruguayan', ->

		it 'number', ->
			# Arrange
			number = "8986565"

			# Act
			result = vtex.phone.countries['598'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

	describe 'a chilean', ->

		number = ''

		afterEach ->
			# Act
			result = vtex.phone.countries['56'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

		it 'number with 8 digits', ->
			# Arrange
			number = "98986565"
			
		it 'number with 7 digits', ->
			# Arrange
			number = "8986565"

		it 'number with 6 digits', ->
			# Arrange
			number = "986565"

	describe 'an american', ->

		it 'number', ->
			# Arrange
			number = "8986565"

			# Act
			result = vtex.phone.countries['1'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

	describe 'a colombian', ->

		it 'land line number', ->
			# Arrange
			number = "8986565"

			# Act
			result = vtex.phone.countries['57'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

		it 'mobile number', ->
			# Arrange
			number = "3018986565"

			# Act
			result = vtex.phone.countries['57'].splitNumber(number)

			# Assert
			expect(result.length).toBe(3)

	describe 'a ecuatorian', ->

		it 'land line number', ->
			# Arrange
			number = "2345678"

			# Act
			result = vtex.phone.countries['593'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

		it 'mobile number', ->
			# Arrange
			number = "912345678"

			# Act
			result = vtex.phone.countries['593'].splitNumber(number)

			# Assert
			expect(result.length).toBe(3)

	describe 'a peruvian', ->

		it 'land line number from metropolitan area', ->
			# Arrange
			number = "9896565"

			# Act
			result = vtex.phone.countries['51'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

		it 'land line number', ->
			# Arrange
			number = "989898"

			# Act
			result = vtex.phone.countries['51'].splitNumber(number)

			# Assert
			expect(result.length).toBe(2)

		it 'mobile number', ->
			# Arrange
			number = "989656989"

			# Act
			result = vtex.phone.countries['51'].splitNumber(number)

			# Assert
			expect(result.length).toBe(3)

	describe 'a paraguayan', ->

			it 'number with 7 digits', ->
				# Arrange
				number = "9896565"

				# Act
				result = vtex.phone.countries['595'].splitNumber(number)

				# Assert
				expect(result.length).toBe(2)

			it 'number with 6 digits', ->
				# Arrange
				number = "896565"

				# Act
				result = vtex.phone.countries['595'].splitNumber(number)

				# Assert
				expect(result.length).toBe(2)

