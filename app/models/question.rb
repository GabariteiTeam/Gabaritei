# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :text
#  year       :datetime
#  area       :string(255)
#  subject    :integer
#  created_at :datetime
#  updated_at :datetime
#  hot        :boolean
#  style      :string(255)
#  subject_id :integer
#

class Question < ActiveRecord::Base

	#Relacoes (Answers ainda deve ser implementado)
	has_many :answers
	
						#Acho que seria bom implementar tambem o mesmo tipo de "truque" para o campo Area (Area de conhecimento)
						#Acredito que a gente deveria importar os tipos de subject de um outro arquivo, de forma que possamos adicionar ou
						#Remover areas de conhecimento
						#Uma questao pode ser interdisciplinar, portanto, pode ter mais de uma disciplina (subjects)
						#Por enquanto, temos penas a relacao 1:1 entre subject e question
						#Necessidade de ampliar essa realacao para *:*
						belongs_to :subject

	#Opcoes de tipo de Questao, funciona mais ou menos como um enum
	STYLE = [
				DISCURSIVE_TYPE = 'Discursiva', 
				ALTERNATIVE_TYPE = 'Alternativa'
			]
	
	#Definicao de questao
	HOT = false
  

  

	#Gosto desse tipo de metodos com interrogacao, acho que eles sao auto explicativos tambem
	def alternative?
		if self.style == STYLE::ALTERNATIVE_TYPE
			return true
		else
			return false
		end
	end
	
	
	#retorna se a questao e quente ou nao
	def hot?
      return self.hot
	end
	

	def discursive?
		if self.style == Question::DISCURSIVE_TYPE
			return true
		else
			return false
		end
	end

	#Funciona como um set para tipo de alternativa, nao seria necessario fazer isso no Model, mas ao fazer desse modo, 
	#evitamos alguns typos. Depois do set o model ainda precisa ser salvo la no controller!
	#Best practices: http://rails-bestpractices.com/posts/708-clever-enums-in-rails
	def discursive_type
		self.style = Question::DISCURSIVE_TYPE
	end

	def alternative_type
		self.style = Question::ALTERNATIVE_TYPE
	end


end
