if Rails.env == 'development'

# ROLES

role_student = Role.all.second
role_teacher = Role.all.third


# COURSES

course = Course.new
course.category = Field.where(name: "Álgebra")[0]
course.name = "Álgebra básica 1"
course.description = "Curso de álgebra básica destinado aos alunos do primeiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[0])    # Irene Hill
course.users.concat(User.where(role_id: role_student.id)[0..9]) # Students from 0 to 9
course.save!

course = Course.new
course.category = Field.where(name: "Geometria")[0]
course.name = "Geometria 3"
course.description = "Curso de geometria para alunos do terceiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[0])      # Irene Hill
course.users.concat(User.where(role_id: role_student.id)[10..19]) # Students from 10 to 19
course.save!

course = Course.new
course.category = Field.where(name: "Literatura")[0]
course.name = "Literatura brasileira pré-modernismo"
course.description = "Curso sobre os grandes autores brasileiros dos séculos XVII, XVIII e XIX."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[1])     # Philip Morgan
course.users.concat(User.where(role_id: role_student.id)[5..14]) # Students from 5 to 14
course.save!

course = Course.new
course.category = Subject.where(name: "Física")[0]
course.name = "Física elementar 1"
course.description = "Curso básico de física (todas as áreas) para alunos do primeiro ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[2])    # Patrick Murray
course.users.concat(User.where(role_id: role_student.id)[0..9]) # Students from 0 to 9
course.save!

course = Course.new
course.category = Subject.where(name: "Biologia")[0]
course.name = "Biologia 2"
course.description = "Curso básico de biologia (todas as áreas) para alunos do segundo ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[3])     # Jeremy Murphy
course.users.concat(User.where(role_id: role_student.id)[8..14]) # Students from 5 to 14
course.save!

course = Course.new
course.category = Field.where(name: "Química orgânica")[0]
course.name = "Química orgânica 2"
course.description = "Curso de química orgânica para alunos do segundo ano."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[4])     # Ernest Crawford
course.users.concat(User.where(role_id: role_student.id)[7..16]) # Students from 7 to 14
course.save!

course = Course.new
course.category = Subject.where(name: "Geografia")[0]
course.name = "Geografia Geral e do Brasil"
course.description = "Curso de Geografia para todos os alunos."
course.users = []
course.users.concat(User.where(role_id: role_teacher.id)[5])     # Jeffrey Sullivan
course.users.concat(User.where(role_id: role_student.id)[0..19]) # Students from 0 to \9
course.save!

end
