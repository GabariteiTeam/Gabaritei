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
lesson.description = "A primeira aula introduz os alunos ao estudo da álgebra"
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
question.fields = [course.category]
question.owner = course.users[0]
question.text = "<p>A porcentagem de fumantes de uma cidade é de 32%. Se 3 em cada 11 fumantes deixarem de fumar, o número de fumantes ficará reduzido a 12800. Calcule</p><p>a) o número de fumantes da cidade<p/><p>b) o número de habitantes da cidade</p>"
question.answer = "Gabarito dado em sala."
question.hot = true
question.source = "FUVEST"
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

course = Course.new
course.category = Field.where(name: "Literatura")[0]
course.name = "Literatura brasileira pré-modernismo"
course.description = "Curso sobre os grandes autores brasileiros dos séculos XVII, XVIII e XIX."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[1])     
course.users.concat(User.where(role_id: role_student.id)[5..14]) 
course.save!

course = Course.new
course.category = Subject.where(name: "Física")[0]
course.name = "Física elementar 1"
course.description = "Curso básico de física (todas as áreas) para alunos do primeiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[2])    
course.users.concat(User.where(role_id: role_student.id)[0..9]) 
course.save!

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

#end
