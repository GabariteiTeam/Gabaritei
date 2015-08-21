# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# PERMISSIONS
Permission.new({name: 'crud.role'}).save!
Permission.new({name: 'crud.user'}).save!
Permission.new({name: 'crud.courses'}).save!
Permission.new({name: 'crud.subjects_and_fields'}).save!
Permission.new({name: 'crud.questions'}).save!
Permission.new({name: 'crud.tests'}).save!
Permission.new({name: 'crud.role'}).save!
