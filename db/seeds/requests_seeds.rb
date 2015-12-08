if Rails.env == 'development'

	request = RegistrationRequest.new
	request.first_name = "Luiz Bryan"
	request.last_name = "Alves"
	request.email = "luiz_bryan@geometrabte.com.br"
	request.birthdate = "1993-01-11"
	request.text = "Gostaria de ser inscrito no sistema Gabaritei."
	request.save!

	request = RegistrationRequest.new
	request.first_name = "Isadora Yasmin"
	request.last_name = "Gomes"
	request.email = "isadora_yasmin@cafefrossard.com"
	request.birthdate = "1993-01-27"
	request.text = "Gostaria de ser inscrito no sistema Gabaritei."
	request.save!

	request = RegistrationRequest.new
	request.first_name = "Murilo Alexandre"
	request.last_name = "Mendes"
	request.email = "mamendes@mtc.eng.br"
	request.birthdate = "1995-11-09"
	request.text = "Gostaria de ser inscrito no sistema Gabaritei."
	request.save!

	students = User.where(role_id: Role.second.id)
	courses = Course.all

	request = CourseRegistrationRequest.new
	request.requirer = students.sample
	request.course = courses.sample
	request.text = "Gostaria de ser inscrito neste curso."
	request.save!

	request = CourseRegistrationRequest.new
	request.requirer = students.sample
	request.course = courses.sample
	request.text = "Gostaria de ser inscrito neste curso."
	request.save!

	request = CourseRegistrationRequest.new
	request.requirer = students.sample
	request.course = courses.sample
	request.text = "Gostaria de ser inscrito neste curso."
	request.save!

end