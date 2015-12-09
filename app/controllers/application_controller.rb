class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng
  respond_to :html, :json
  before_action :verify_authentication

	def set_csrf_cookie_for_ng
	  cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
	end
	def verified_request?
		super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
	end

	def verify_authentication
	  	if !user_signed_in? 
	  		render json: {error: "Unauthorized access"}, status: 401
	  	end
  	end
end
