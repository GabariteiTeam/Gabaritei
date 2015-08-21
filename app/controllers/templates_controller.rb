class TemplatesController < ApplicationController
  
  def home
  	render 'templates/home/home'
  end

  def serve
  	render file: 'templates/' + params[:path], layout: false
  end
    
end
