if Rails.env == 'development'

	# SUBJECTS

	subject_portuguese = Subject.new
	subject_portuguese.name = "Português"
	subject_portuguese.description = "Em Português, os alunos aprendem a gramática e os grandes autores da língua portuguesa, bem como redigir textos."
	subject_portuguese.save!

	subject_math = Subject.new
	subject_math.name = "Matemática"
	subject_math.description = "A Matemática tem como objetivo instigar o raciocínio lógico dos alunos, apresentando os mais diversos conceitos de diversas áreas."
	subject_math.save!

	subject_history = Subject.new
	subject_history.name = "História"
	subject_history.description = "A matéria de História engloba toda a história geral, e dá um enfoque para a história do Brasil e seu desenvolvimento."
	subject_history.save!

	subject_geography = Subject.new
	subject_geography.name = "Geografia"
	subject_geography.description = "O estudo da Geografia dá a possibilidade aos alunos de desenvolverem um olhar crítico sobre a sociedade dos dias de hoje e conhecerem o mundo que os rodeia."
	subject_geography.save!

	subject_physics = Subject.new
	subject_physics.name = "Física"
	subject_physics.description = "Em Física, aprendemos como a natureza funciona, como, quando e porque as coisas acontecem."
	subject_physics.save!

	subject_chemistry = Subject.new
	subject_chemistry.name = "Química"
	subject_chemistry.description = "Nos estudos de química, os alunos entram em contato com o mundo dos elementos, suas reações e características."
	subject_chemistry.save!

	subject_biology = Subject.new
	subject_biology.name = "Biologia"
	subject_biology.description = "A Biologia visa ensinar sobre o desenvolvimento da vida e da natureza."
	subject_biology.save!

	# FIELDS

	field = Field.new
	field.name = "Redação"
	field.description = "Desenvolvimento creativo de textos, instigando a argumentação coesa e coerente, sob um olhar crítico."
	field.subject = subject_portuguese
	field.save!

	field = Field.new
	field.name = "Literatura"
	field.description = "Estudos sobre os grandes autores brasileiros e internacionais ao decorrer da história."
	field.subject = subject_portuguese
	field.save!

	field = Field.new	
	field.name = "Gramática"
	field.description = "Construções gramaticais, morfologia das palavras, sintaxe e semântica."
	field.subject = subject_portuguese
	field.save!

	field = Field.new
	field.name = "Álgebra"
	field.description = "Equações, polinômios, funções, números e operações."
	field.subject = subject_math
	field.save!

	field = Field.new
	field.name = "Geometria"
	field.description = "Estudos sobre as formas, as proporções, as medidas e trigonometria."
	field.subject = subject_math
	field.save!

	field = Field.new
	field.name = "Estatística"
	field.description = "Ánalise de dados, combinatória e probabilidade estão contidos na estatística."
	field.subject = subject_math
	field.save!


	field = Field.new
	field.name = "História do Brasil"
	field.description = "O desenvolvimento do Brasil e da sociedade brasileira."
	field.subject = subject_history
	field.save!
	field = Field.new
	field.name = "História geral"
	field.description = "Estudos sobre história do mundo, desde a antiguidade até os dias de hoje."
	field.subject = subject_history
	field.save!


	field = Field.new
	field.name = "Geopolítica"
	field.description = "Estudos sobre os conflitos e a organização do mundo e da sociedade de hoje."
	field.subject = subject_geography
	field.save!
	field = Field.new
	field.name = "Geografia física"
	field.description = "Estudos sobre relevos, rios, vegetação, mares e oceanos, clima, tectônica de placas."
	field.subject = subject_geography
	field.save!


	field = Field.new
	field.name = "Mecânica"
	field.description = "Fenomenologia cotidiana, variação e conservação da quantidade de movimento, energia e potência associadas aos movimentos, equilíbrios e desequilíbrios."
	field.subject = subject_physics
	field.save!
	field = Field.new
	field.name = "Termodinâmica"
	field.description = "Fontes e trocas de calor, tecnologias que usam calor, motores e refrigeradores, o calor na vida e no ambiente."
	field.subject = subject_physics
	field.save!
	field = Field.new
	field.name = "Eletromagnetismo"
	field.description = "Aparelhos elétricos, motores elétricos, geradores, emissores e receptores."
	field.subject = subject_physics
	field.save!

	field = Field.new
	field.name = "Química inorgânica"
	field.description = "O estudo das reações inorgânicas e das propriedades fundamentais da matéria."
	field.subject = subject_chemistry
	field.save!
	field = Field.new
	field.name = "Química orgânica"
	field.description = "Moléculas, compostos, substâncias e materiais e suas implicações com o meio ambiente e a vida."
	field.subject = subject_chemistry
	field.save!


	field = Field.new
	field.name = "Zoologia"
	field.description = "Estudos sobre a interação entre os animais e os ecossistemas, classificação, taxonomia e morfologia dos animais."
	field.subject = subject_biology
	field.save!
	field = Field.new
	field.name = "Botânica"
	field.description = "Classificação dos vegetais, desenvolvimento da vida vegetal, ecologia."
	field.subject = subject_biology
	field.save!
	field = Field.new
	field.name = "Genética"
	field.description = "Estudos sobre genes, DNA, cromossomos, divisão celular, doenças hereditárias."
	field.subject = subject_biology
	field.save!


end