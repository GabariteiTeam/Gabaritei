# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@ajaxFilter = () ->
	id = $("#filtrar").val()
	$.get "/questions/getQuestionsSubject/" + id
	  .done (data) -> populateQuestions(data)



populateQuestions = (data)->
	i=0
	$("#subjectsBody").html("")


	for question in data[0]
		if not question.area
			question.area = ""
		$("#subjectsBody").append("<tr id= '#{i}'>")
		$("#" + i).append ("<td> #{question.text}</td>")
		$("#" + i).append ("<td> #{question.type}</td>")
		$("#" + i).append ("<td> #{question.year}</td>")
		$("#" + i).append ("<td> #{getSubject question.subjects.first.id, data[1]}</td>")
		$("#" + i).append ("<td> <a href='/questions/#{question.id}'>Show</a></td>")
		$("#" + i).append ("<td><a href='/questions/#{question.id}/edit'>Edit</a> </td>")
		$("#" + i).append ("<td><a data-confirm='Are you sure?'' data-method='delete' href='/questions/#{question.id}' rel='nofollow'>Destroy</a> </td>")
		$("#subjectsBody").append('</tr>')
		i=i+1

getSubject = (id, subjects) ->
	for subject in subjects
		if id == subject.id
			return subject.name