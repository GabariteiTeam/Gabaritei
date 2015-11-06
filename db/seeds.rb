# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# PERMISSIONS

permission_manage_registration_requests = Permission.new({name: 'permission.manage_registration_requests'})
permission_manage_registration_requests.save!

permission_manage_course_registration_requests = Permission.new({name: 'permission.manage_course_registration_requests'})
permission_manage_course_registration_requests.save!

permission_manipulate_courses = Permission.new({name: 'permission.manipulate_courses'})
permission_manipulate_courses.save!

permission_take_part_in_courses = Permission.new({name: 'permission.take_part_in_courses'})
permission_take_part_in_courses.save!

permission_manipulate_users = Permission.new({name: 'permission.manipulate_users'})
permission_manipulate_users.save!

permission_manipulate_subjects = Permission.new({name: 'permission.manipulate_subjects'})
permission_manipulate_subjects.save!

permission_manipulate_contents = Permission.new({name: 'permission.manipulate_contents'})
permission_manipulate_contents.save!

permission_manipulate_roles = Permission.new({name: 'permission.manipulate_roles'})
permission_manipulate_roles.save!

permission_manipulate_questions = Permission.new({name: 'permission.manipulate_questions'})
permission_manipulate_questions.save!

permission_import_data = Permission.new({name: 'permission.import_data'})
permission_import_data.save!

# ROLES

# Admin
role_admin = Role.new(name: "Admin")
role_admin.permissions = [
	permission_take_part_in_courses,
	permission_manipulate_courses,
	permission_manipulate_roles,
	permission_manipulate_users,
	permission_manipulate_questions,
	permission_manipulate_subjects,
	permission_manipulate_contents,
	permission_manage_registration_requests,
	permission_manage_course_registration_requests,
	permission_import_data
]
role_admin.save!

# Student
role_student = Role.new(name: "Student")
role_student.permissions = [
	permission_take_part_in_courses
]
role_student.save!

# Teacher
role_teacher = Role.new(name: "Teacher")
role_teacher.permissions = [
	permission_take_part_in_courses,
	permission_manipulate_contents,
	permission_manipulate_questions
]
role_teacher.save!

# ADMIN USER
user = User.new
user.first_name = 'Admin'
user.last_name = 'Admin'
user.email = 'admin@gabaritei.com'
user.password = '12345678'
user.password_confirmation = '12345678'
user.role = role_admin
user.save!

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
