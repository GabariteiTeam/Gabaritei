# == Description
#
#
# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  text       :text
#  answer     :text
#  hot        :boolean
#  source     :string(255)
#  date       :datetime
#  style      :string(255)
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#

class Question < ActiveRecord::Base

	belongs_to :user
	has_many :course_questions
	has_many :question_categories
	has_many :subjects, through: :question_categories, source: :category, source_type: "Subject"
	has_many :fields, through: :question_categories, source: :category, source_type: "Field"
	has_many :question_choices
	has_many :medias, as: :owner
	has_many :ratings
	has_many :recommendations, as: :resource
	has_many :responses											
	has_many :test_questions
	has_many :tests, through: :test_questions
	
	#Opcoes de tipo de Questao, funciona mais ou menos como um enum
	STYLES = [
		STYLE_WRITTEN = 'written', 
		STYLE_CHOICE = 'choice'
	]
	
	#Gosto desse tipo de metodos com interrogacao, acho que eles sao auto explicativos tambem
	def multiple_choice?
		(self.style == Question::STYLE_MULTIPLE_CHOICE)
	end

	def written?
		(self.style == Question::STYLE_TYPE_WRITTEN)
	end
	
	#retorna se a questao e quente ou nao
	def hot?
      self.hot
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
