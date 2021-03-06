

# CONTENTS PERMISSIONS
p_contents_globally_manipulate = Permission.new({name: "permission.contents.globally_manipulate"})
p_contents_globally_manipulate.save!
p_contents_manipulate = Permission.new({name: "permission.contents.manipulate"})
p_contents_manipulate.save!

# COURSES PERMISSIONS
p_courses_manipulate = Permission.new({name: "permission.courses.manipulate"})
p_courses_manipulate.save!
p_courses_take_part = Permission.new({name: "permission.courses.take_part"})
p_courses_take_part.save!

# USERS PERMISSIONS
p_users_manipulate = Permission.new({name: "permission.users.manipulate"})
p_users_manipulate.save!

# ROLES PERMISSIONS
p_roles_manipulate = Permission.new({name: "permission.roles.manipulate"})
p_roles_manipulate.save!

# QUESTIONS PERMISSIONS
p_questions_globally_manipulate = Permission.new({name: "permission.questions.globally_manipulate"})
p_questions_globally_manipulate.save!
p_questions_manipulate = Permission.new({name: "permission.questions.manipulate"})
p_questions_manipulate.save!

# SUBJECTS AND FIELDS PERMISSIONS
p_subjects_fields_manipulate = Permission.new({name: "permission.subjects_fields.manipulate"})
p_subjects_fields_manipulate.save!

# REQUESTS PERMISSIONS
p_registration_requests_manage = Permission.new({name: "permission.requests.registration.manage"})
p_registration_requests_manage.save!
p_course_registration_requests_manage = Permission.new({name: "permission.requests.course.manage"})
p_course_registration_requests_manage.save!

# DATA IMPORT PERMISSIONS
p_import_data = Permission.new({name: "permission.import_data"})
p_import_data.save!

# ADMIN ROLE
role_admin = Role.new(name: "Admin")
role_admin.permissions = [
	p_contents_globally_manipulate,
	p_courses_manipulate,
	p_users_manipulate,
	p_roles_manipulate,
	p_questions_globally_manipulate,
	p_subjects_fields_manipulate,
	p_registration_requests_manage,
	p_course_registration_requests_manage,
	p_import_data
]
role_admin.save!

# STUDENT ROLE
role_student = Role.new(name: "Student")
role_student.permissions = [
	p_courses_take_part
]
role_student.save!

# TEACHER ROLE
role_teacher = Role.new(name: "Teacher")
role_teacher.permissions = [
	p_courses_take_part,
	p_contents_manipulate,
	p_questions_manipulate
]
role_teacher.save!