# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

teacher_role = Role.create(name: "Teacher")
student_role = Role.create(name: "Student")

teacher1 = User.create(name: "Teacher 1", role: teacher_role)
teacher2 = User.create(name: "Teacher 2", role: teacher_role)

student1 = User.create(name: "Student 1", role: student_role)
student2 = User.create(name: "Student 2", role: student_role)
student3 = User.create(name: "Student 3", role: student_role)

subject_math = Subject.create(name: "Math")
subject_physics = Subject.create(name: "Physics")

course1 = Course.create(name: "Math course", 
                        subject: subject_math, 
                        teachers: [teacher1],
                        students: [student1, student2])
                        
course2 = Course.create(name: "Physics course", 
                        subject: subject_physics,
                        teachers: [teacher1, teacher2],
                        students: [student2, student3])
                        
q1 = Question.create(user: teacher1, subjects: [subject_math, subject_physics])
q2 = Question.create(user: teacher2, subjects: [subject_physics])
q3 = Question.create(user: teacher1, subjects: [subject_math])

t1 = Test.create(user: teacher1, course: course1, questions: [q1, q2])
t2 = Test.create(user: teacher2, course: course2, questions: [q2, q3])

rating1 = Rating.create(user: student1, question: q1, level: 5.0)
rating2 = Rating.create(user: student2, question: q1, level: 7.0)
rating3 = Rating.create(user: student1, question: q2, level: 8.0)
rating4 = Rating.create(user: student3, question: q2, level: 2.0)

response1 = Response.create(user: student1, question: q1)
response2 = Response.create(user: student2, question: q1)
response3 = Response.create(user: student1, question: q2)
response4 = Response.create(user: student3, question: q2)

content1 = Content.create(subject: subject_math, user: teacher1)
content2 = Content.create(subject: subject_physics, user: teacher2)