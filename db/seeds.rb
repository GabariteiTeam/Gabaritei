# coding: utf-8

Permission.destroy_all
Role.destroy_all
User.destroy_all
Subject.destroy_all
Field.destroy_all
Course.destroy_all
Question.destroy_all
Response.destroy_all
Test.destroy_all
Rating.destroy_all

seeds_files = [
	"permissions_roles_seeds",
	"users_admin_seeds",
	"users_teachers_seeds",
	"users_students_seeds",
	"subjects_fields_seeds",
	"courses_seeds",
	"requests_seeds"
]

seeds_files.each do |f|
	require File.dirname(__FILE__) + "/seeds/#{f}.rb"
end
