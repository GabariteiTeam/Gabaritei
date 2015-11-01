# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# PERMISSIONS
permission_take_part_in_courses = Permission.new({name: 'permission.take_part_in_courses'})
permission_take_part_in_courses.save!

permission_manipulate_users = Permission.new({name: 'permission.manipulate_users'})
permission_manipulate_users.save!

# ROLES

# Admin
role_admin = Role.new(name: "Admin")
role_admin.permissions = [
	permission_take_part_in_courses,
	permission_manipulate_users
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
	permission_take_part_in_courses
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
