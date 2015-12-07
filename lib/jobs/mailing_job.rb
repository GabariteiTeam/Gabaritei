class MailingJob < Struct.new(:mail)

	def perform
		mail.deliver
	end

	def max_attempts
    	1
  	end

end