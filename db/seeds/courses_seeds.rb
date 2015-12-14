#if Rails.env == 'development'

# ROLES

role_student = Role.all.second
role_teacher = Role.all.third


# COURSES

course = Course.new
course.category = Field.where(name: "Álgebra")[0]
course.name = "Álgebra básica 1"
course.description = "Curso de álgebra básica destinado aos alunos do primeiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[0])    
course.users.concat(User.where(role_id: role_student.id)[0..9])
course.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Aula 1: Introdução"
lesson.description = "A primeira aula introduz os alunos ao estudo da álgebra."
lesson.save!

content = Content.new
content.category = course.category
content.owner = course.users[0]
content.name = "What is algebra?"
content.description = "Vídeo em inglês sobre o que é algebra."
content.shareable = true
content.medium = Medium.new
content.medium.reference = "https://www.youtube.com/embed/NybHckSEQBI"
content.medium.is_attachment = false
content.lessons = [lesson]
content.save!

question = Question.new
question.subjects = [course.category.subject]
question.owner = course.users[0]
question.text = "<p>A porcentagem de fumantes de uma cidade é de 32%. Se 3 em cada 11 fumantes deixarem de fumar, o número de fumantes ficará reduzido a 12800. Calcule</p><p>a) o número de fumantes da cidade<p/><p>b) o número de habitantes da cidade</p>"
question.answer = "Gabarito dado em sala."
question.hot = true
question.source = "FUVEST"
question.style = "written"
question.lessons = [lesson]
question.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Aula 2: Operações básicas"
lesson.description = "Nesta aula, vemos as operações básicas da álgebra, retomando os conceitos aritméticos."
lesson.save!

content = Content.new
content.category = course.category
content.owner = course.users[0]
content.name = "Operações básicas da álgebra"
content.description = "Documento explicando as operações básicas da álgebra"
content.shareable = true
content.medium = Medium.new
content.medium.reference = "https://docs.google.com/document/d/1WhrE9daZK4IEEjzftCQfdmXN2NiYcpQ2wt1mfpGBrIg/edit?usp=sharing"
content.medium.is_attachment = false
content.lessons = [lesson]
content.save!

question = Question.new
question.subjects = [course.category.subject]
question.owner = course.users[0]
question.text = "<p>Seja <i>a</i> um número real positivo e considere as funções afins <i>f(x) = ax + 3a</i> e <i>g(x) = 9 − 2x</i>, definidas para todo número real <i>x</i>.</p>" +
				"<p>a) Encontre o <b>número de soluções</b> inteiras da inequação <i>f(x)g(x) > 0</i>.</p>" +
				"<p>b) Encontre o <b>valor de <i>a</i></b> tal que <i>f(g(x)) = g(f(x))</i> para todo número real <i>x</i>.</p>"
question.answer = "Gabarito dado em sala."
question.hot = false
question.source = "UNICAMP"
question.style = "written"
question.lessons = [lesson]
question.save!

course = Course.new
course.category = Field.where(name: "Geometria")[0]
course.name = "Geometria 3"
course.description = "Curso de geometria para alunos do terceiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[0])      
course.users.concat(User.where(role_id: role_student.id)[10..19]) 
course.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Aula 1: Introdução à trigonometria"
lesson.description = "Começamos o curso de geometria com a introdução da trigonometria e seus conceitos."
lesson.save!

question = Question.new
question.subjects = [course.category.subject]
question.owner = course.users[0]
question.text = "<p>O número real <i>x</i>, com <i>0 < x < π</i> satisfaz a equação:</p>" +
				"<p><i>log<sub>3</sub>(1 − cos(x)) + log<sub>3</sub>(1 + cos(x)) = −2</i></p>" +
				"<p>então <i>cos(2x) + sen(x)</i> vale:</p>"
question.question_choices = [
	QuestionChoice.new(text: "1/3", correct: false),
	QuestionChoice.new(text: "2/3", correct: false),
	QuestionChoice.new(text: "7/9", correct: false),
	QuestionChoice.new(text: "8/9", correct: false),
	QuestionChoice.new(text: "10/9", correct: true)
]
question.answer = "4";
question.hot = true
question.source = "FUVEST"
question.style = "choice"
question.lessons = [lesson]
question.save!

course = Course.new
course.category = Field.where(name: "Literatura")[0]
course.name = "Literatura brasileira pré-modernismo"
course.description = "Curso sobre os grandes autores brasileiros dos séculos XVII, XVIII e XIX."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[1])     
course.users.concat(User.where(role_id: role_student.id)[5..14]) 
course.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Quinhentismo"
lesson.description = "A primeira aula é sobre o Quinhentismo, o primeiro movimento literário brasileiro."
lesson.save!

content = Content.new
content.category = course.category
content.owner = course.users[0]
content.name = "Resumo sobre Quinhentismo"
content.description = "Resumo da aula."
content.shareable = false
content.medium = Medium.new
content.medium.reference = "https://www.dropbox.com/s/6ed81i7bb6d5w1d/OQuinhentismo.pdf?dl=1"
content.medium.is_attachment = false
content.lessons = [lesson]
content.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Barroco"
lesson.description = "Esta aula trata do barroco brasileiro."
lesson.save!

question = Question.new
question.subjects = [course.category.subject]
question.owner = course.users[0]
question.text = '<p>No colégio dos padres, Gregório de Matos escreveu: </p>' +
				'<p>Quando desembarcaste da fragata, meu dom Braço de Prata, cuidei, ' +
				'que a esta cidade tonta, e fátua*, mandava a Inquisição alguma ' +
				'estátua, vendo tão espremida salvajola* visão de palha sobre um mariola*.</p>' +
				'<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sorriu, e entregou o escrito a Gonçalo Ravasco.</p>' +
				'<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gonçalo leu-o, gracejou, entregou-o ao vereador.</p>' +
				'<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O papel passou de mão em mão.</p>' +
				'<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"A difamação é o teu deus", disseram, sorrindo.</p>' +
				'<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Ana Miranda, Boca do Inferno)</p>' +
				'<p>(*fátua: tola ; *salvajola: variante de "selvagem" ; *mariola: velhaco)</p>' +
				'<p>O trecho ilustra:</p>'
question.question_choices = [
	QuestionChoice.new(text: 'a poesia erótica de Gregório de Matos, inspirada na vida nos prostíbulos da cidade da Bahia e que deu origem à alcunha do poeta, "Boca do Inferno".', correct: false),
	QuestionChoice.new(text: 'a poesia lírica de Gregório de Matos, voltada para a temática filosófica, em linguagem marcada pelos recursos da estética barroca.', correct: false),
	QuestionChoice.new(text: 'a poesia satírica de Gregório de Matos, dedicada à descrição fiel da sociedade da época, utilizando recursos expressivos característicos do barroco português.', correct: false),
	QuestionChoice.new(text: 'a poesia erótica de Gregório de Matos, caracterizada pela crítica aos comportamentos e às autoridades baianas da época colonial.', correct: true),
	QuestionChoice.new(text: 'a poesia satírica de Gregório de Matos, que representa, no conjunto de sua obra, uma fuga aos moldes barrocos e ataca, no linguajar baiano da época, costumes e personalidades.', correct: false),
]
question.answer = "3";
question.hot = false
question.source = "FATEC"
question.style = "choice"
question.lessons = [lesson]
question.save!


course = Course.new
course.category = Subject.where(name: "Física")[0]
course.name = "Física elementar 1"
course.description = "Curso básico de física (todas as áreas) para alunos do primeiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[2])    
course.users.concat(User.where(role_id: role_student.id)[0..9]) 
course.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Mecânica: Leis de Newton"
lesson.description = "Exploramos nesta aula as 3 leis de Newton e seus significados."
lesson.save!

content = Content.new
content.category = course.category
content.owner = course.users[0]
content.name = "Newton's 3 Laws, with a bicycle - Joshua Manley"
content.description = "Vídeo do Ted-Ed sobre as 3 leis de Newton."
content.shareable = true
content.medium = Medium.new
content.medium.reference = "https://www.youtube.com/embed/JGO_zDWmkvk"
content.medium.is_attachment = false
content.lessons = [lesson]
content.save!

question = Question.new
question.subjects = [course.category]
question.owner = course.users[0]
question.text = 'Assinale a alternativa que apresenta o enunciado da Lei da Inércia, também conhecida como Primeira Lei de Newton.'
question.question_choices = [
	QuestionChoice.new(text: 'Qualquer planeta gira em torno do Sol descrevendo uma órbita elíptica, da qual o Sol ocupa um dos focos.', correct: false),
	QuestionChoice.new(text: 'Dois corpos quaisquer se atraem com uma força proporcional ao produto de suas massas e inversamente proporcional ao quadrado da distância entre eles.', correct: false),
	QuestionChoice.new(text: 'Quando um corpo exerce uma força sobre outro, este reage sobre o primeiro com uma força de mesma intensidade e direção, mas de sentido contrário.', correct: false),
	QuestionChoice.new(text: 'A aceleração que um corpo adquire é diretamente proporcional à resultante das forças que nele atuam, e tem mesma direção e sentido dessa resultante.', correct: false),
	QuestionChoice.new(text: 'Todo corpo continua em seu estado de repouso ou de movimento uniforme em uma linha reta, a menos que sobre ele estejam agindo forças com resultante não nula.', correct: true),
]
question.answer = "4";
question.hot = false
question.source = "VUNESP-SP"
question.style = "choice"
question.lessons = [lesson]
question.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Mecânica: Quantidade de movimento e energia"
lesson.description = "Abordamos nesta aula os conceitos de quantidade de movimento e energia"
lesson.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Eletromagnetismo: Campo elétrico"
lesson.description = "Introduzimos o conceito de campo elétrico, e estudamos suas propriedades."
lesson.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Eletromagnetismo: Campo magnético"
lesson.description = "Introduzimos o conceito de campo magnético, e estudamos suas propriedades."
lesson.save!

course = Course.new
course.category = Subject.where(name: "Biologia")[0]
course.name = "Biologia 2"
course.description = "Curso básico de biologia (todas as áreas) para alunos do segundo ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[3])     
course.users.concat(User.where(role_id: role_student.id)[8..14]) 
course.save!

course = Course.new
course.category = Field.where(name: "Química orgânica")[0]
course.name = "Química orgânica 2"
course.description = "Curso de química orgânica para alunos do segundo ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[4])     
course.users.concat(User.where(role_id: role_student.id)[7..16]) 
course.save!

course = Course.new
course.category = Subject.where(name: "Geografia")[0]
course.name = "Geografia Geral e do Brasil"
course.description = "Curso de Geografia para todos os alunos."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[5])     
course.users.concat(User.where(role_id: role_student.id)[0..19]) 
course.save!


lesson = Lesson.new
lesson.course = course
lesson.title = "Aula 1: Relevo brasileiro"
lesson.description = "Uma visão geral sobre o relevo brasileiro."
lesson.save!

lesson = Lesson.new
lesson.course = course
lesson.title = "Aula 2: Rios brasileiros"
lesson.description = "Os rios brasileiros e sua importância social."
lesson.save!

#end

