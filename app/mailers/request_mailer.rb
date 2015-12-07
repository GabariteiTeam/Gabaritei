class RequestMailer < ActionMailer::Base

	default from: "no-reply@gabaritei.com"

	def registration_request_accepted(request, password)
		@request = request
		@password = password
		mail(:to => request.email, :subject => 'Registration at Gabaritei')
	end

	def course_registration_request_accepted(request)
		@request = request
		mail(:to => request.requirer.email, :subject => 'Course inscription accepted at Gabaritei')
	end

	def registration_request_rejected(request)
		@request = request
		mail(:to => request.email, :subject => 'Rejected registration at Gabaritei')
	end

	def course_registration_request_rejected(request)
		@request = request
		mail(:to => request.requirer.email, :subject => 'Course inscription rejected')
	end

end