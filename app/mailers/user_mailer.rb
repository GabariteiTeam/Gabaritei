class UserMailer < ActionMailer::Base

	default from: "no-reply@gabaritei.com"

	def password_creation(user, password)
		@user = user
		@password = password
		mail(:to => user.email, :subject => 'Registration at Gabaritei')
	end

end