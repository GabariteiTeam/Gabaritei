#  ---------------------------------------------------------
#     PERMISSIONS
#  ---------------------------------------------------------

# CONTENT PERMISSIONS

p_contents_globally_manipulate = Permission.new({name: 'permission.contents.globally_manipulate'})
p_contents_manipulate.save!

p_manipulate_contents = Permission.new({name: 'permission.contents.manipulate'})
p_manipulate_contents.save!



p_manage_registration_requests = Permission.new({name: 'permission.manage_registration_requests'})
p_manage_registration_requests.save!

p_manage_course_registration_requests = Permission.new({name: 'permission.manage_course_registration_requests'})
p_manage_course_registration_requests.save!

p_manipulate_courses = Permission.new({name: 'permission.manipulate_courses'})
p_manipulate_courses.save!

p_take_part_in_courses = Permission.new({name: 'permission.take_part_in_courses'})
p_take_part_in_courses.save!

p_manipulate_users = Permission.new({name: 'permission.manipulate_users'})
p_manipulate_users.save!

p_manipulate_subjects = Permission.new({name: 'permission.manipulate_subjects'})
p_manipulate_subjects.save!



p_manipulate_roles = Permission.new({name: 'permission.manipulate_roles'})
p_manipulate_roles.save!

p_manipulate_questions = Permission.new({name: 'permission.manipulate_questions'})
p_manipulate_questions.save!

p_import_data = Permission.new({name: 'permission.import_data'})
p_import_data.save!

#  ---------------------------------------------------------
#     STANDARD ROLES
#  ---------------------------------------------------------

# Admin
role_admin = Role.new(name: "Admin")
role_admin.permissions = [
	p_take_part_in_courses,
	p_manipulate_courses,
	p_manipulate_roles,
	p_manipulate_users,
	p_manipulate_questions,
	p_manipulate_subjects,
	p_contents_globally_manipulate,
	p_manage_registration_requests,
	p_manage_course_registration_requests,
	p_import_data
]
role_admin.save!

# Student
role_student = Role.new(name: "Student")
role_student.permissions = [
	p_take_part_in_courses
]
role_student.save!

# Teacher
role_teacher = Role.new(name: "Teacher")
role_teacher.permissions = [
	p_take_part_in_courses,
	p_manipulate_contents,
	p_manipulate_questions
]
role_teacher.save!

#  ---------------------------------------------------------
#     STANDARD ADMIN USER
#  ---------------------------------------------------------

# ADMIN USER
user = User.new
user.first_name = 'Admin'
user.last_name = 'Admin'
user.email = 'admin@gabaritei.com'
user.password = '12345678'
user.password_confirmation = '12345678'
user.role = role_admin
user.save!

#  ---------------------------------------------------------
#     DEVELOPMENT TEST DATA
#  ---------------------------------------------------------

if Rails.env == 'development'

	# TEACHER
	user = User.new
	user.first_name = 'Teacher'
	user.last_name = 'Teacher'
	user.email = 'teacher@gabaritei.com'
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_teacher
	user.save!

	# STUDENT
	user = User.new
	user.first_name = 'Student'
	user.last_name = 'Student'
	user.email = 'student@gabaritei.com'
	user.password = '12345678'
	user.password_confirmation = '12345678'
	user.role = role_student
	user.save!

end
