#if Rails.env == 'development'

	role_student = Role.all.second

	user = User.new
	user.first_name = "Luiza"
	user.last_name = "Santos Ferreira"
	user.email = "luiza_santos@nba.com"
	user.birthdate = DateTime.parse("1988-10-27")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Augusto Marcelo"
	user.last_name = "Gomes"
	user.email = "augusto_m_gomes@comdados.com"
	user.birthdate = DateTime.parse("1994-04-24")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Breno Matheus"
	user.last_name = "Pereira"
	user.email = "breno.matheus.pereira@bplan.com.br"
	user.birthdate = DateTime.parse("1992-06-21")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Laura"
	user.last_name = "Reis"
	user.email = "lreis@is.gd"
	user.birthdate = DateTime.parse("1986-09-01")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Glória"
	user.last_name = "Martins"
	user.email = "gmartins@uol.com.br"
	user.birthdate = DateTime.parse("1991-11-13")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "João Caio"
	user.last_name = "Pereira"
	user.email = "joao_i_pereira@drimenezes.com"
	user.birthdate = DateTime.parse("1993-02-23")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Denis"
	user.last_name = "Castro"
	user.email = "dcastro@ucoz.ru"
	user.birthdate = DateTime.parse("1991-06-14")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Lara"
	user.last_name = "Costa"
	user.email = "lcosta@ucsd.edu"
	user.birthdate = DateTime.parse("1991-10-17")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Evelyn"
	user.last_name = "Gomes"
	user.email = "evelyng@creativecommons.org"
	user.birthdate = DateTime.parse("1991-04-19")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Maria"
	user.last_name = "Stella Ribeiro"
	user.email = "msribeiro@com.com"
	user.birthdate = DateTime.parse("1993-09-23")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Maria"
	user.last_name = "Das Flores"
	user.email = "mfloresl@oaic.gov.au"
	user.birthdate = DateTime.parse("1991-06-08")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Samuel Bernardo"
	user.last_name = "Barros"
	user.email = "sbarros@microsoft.com"
	user.birthdate = DateTime.parse("1987-10-09")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Nicolas Henrique"
	user.last_name = "Martins"
	user.email = "npmartins@wisc.edu"
	user.birthdate = DateTime.parse("1986-04-21")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Alexandre"
	user.last_name = "Dias"
	user.email = "alexdias@shareasale.com"
	user.birthdate = DateTime.parse("1994-05-29")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Lucas Guilherme"
	user.last_name = "Dias"
	user.email = "lucas_caua@uol.com.br"
	user.birthdate = DateTime.parse("1990-10-02")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Giovana"
	user.last_name = "Barros"
	user.email = "gbarros@thetimes.co.uk"
	user.birthdate = DateTime.parse("1993-12-03")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Carolina"
	user.last_name = "Pereira Azevedo"
	user.email = "cpazevedo@eepurl.com"
	user.birthdate = DateTime.parse("1995-07-01")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Aline"
	user.last_name = "Alves Ribeiro"
	user.email = "aline_ribeiro@parallels.com"
	user.birthdate = DateTime.parse("1994-09-16")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Luiz"
	user.last_name = "Silva Melo"
	user.email = "lsmelo@blogspot.com"
	user.birthdate = DateTime.parse("1987-02-22")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	user = User.new
	user.first_name = "Tiago"
	user.last_name = "Castro Martins"
	user.email = "tcastro@acquirethisname.com"
	user.birthdate = DateTime.parse("1991-07-25")
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.setting = Setting.new
	user.setting.preferred_language = 0
	user.save!

	

#end