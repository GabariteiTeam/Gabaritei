if Rails.env == 'development'

	role_teacher = Role.third

	user = User.new
	user.first_name = 'Eloá Flávia'
	user.last_name = 'Souza'
	user.email = 'eloa-flavia79@opera.com'
	user.birthdate = DateTime.parse('1980-07-19')
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

	user = User.new
	user.first_name = 'Arthur João'
	user.last_name = 'Giovanni Ribeiro'
	user.email = 'arthur.joao.ribeiro@hp.com'
	user.birthdate = DateTime.parse('1972-07-10')
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

	user = User.new
	user.first_name = 'Clara'
	user.last_name = 'Campos'
	user.email = 'clara_campos@elegantthemes.com'
	user.birthdate = DateTime.parse('1973-07-26')
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

	user = User.new
	user.first_name = 'Henrique Leonardo'
	user.last_name = 'Castro'
	user.email = 'henrique-leonardo93@hibu.com'
	user.birthdate = DateTime.parse('1962-09-21')
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

	user = User.new
	user.first_name = 'Raul'
	user.last_name = 'Gomes'
	user.email = 'raul_enrico@ow.ly'
	user.birthdate = DateTime.parse('1964-05-14')
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

	user = User.new
	user.first_name = 'Alice Marina'
	user.last_name = 'Fernandes'
	user.email = 'aefernandes@claro.com.br'
	user.birthdate = DateTime.parse('1967-07-05')
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

end
