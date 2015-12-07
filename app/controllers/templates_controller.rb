class TemplatesController < ApplicationController

  skip_before_action :verify_authentication

  def home
  	render 'templates/home/home'
  end

  def serve
  	render file: 'templates/' + params[:path], layout: false
  end
  
end
