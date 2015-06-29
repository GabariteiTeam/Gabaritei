class Question < ActiveRecord::Base

	# References
	belongs_to :user

	# Referenced by
	has_many :course_questions
	has_many :question_categories
	has_many :categories, through: :question_categories
	has_many :question_choices
	has_many :question_medias
	has_many :ratings
	has_many :recommendations, :as => :resource
	has_many :responses											
	has_many :test_questions
	has_many :tests, through: :test_questions
	
	#Opcoes de tipo de Questao, funciona mais ou menos como um enum
	STYLES = [
		STYLE_WRITTEN = 'written', 
		STYLE_MULTIPLE_CHOICE = 'multiple choice'
	]
	
	#Definicao de questao
	HOT = false
  
	#Gosto desse tipo de metodos com interrogacao, acho que eles sao auto explicativos tambem
	def multiple_choice?
		return (self.style == Question::STYLE_MULTIPLE_CHOICE)
	end

	def written?
		return (self.style == Question::STYLE_TYPE_WRITTEN)
	end
	
	#retorna se a questao e quente ou nao
	def hot?
      return self.hot
	end
	
	#Funciona como um set para tipo de alternativa, nao seria necessario fazer isso no Model, mas ao fazer desse modo, 
	#evitamos alguns typos. Depois do set o model ainda precisa ser salvo la no controller!
	#Best practices: http://rails-bestpractices.com/posts/708-clever-enums-in-rails
	def written
		self.style = Question::STYLE_WRITTEN
	end

	def multiple_choice
		self.style = Question::STYLE_MULTIPLE_CHOICE
	end

end
