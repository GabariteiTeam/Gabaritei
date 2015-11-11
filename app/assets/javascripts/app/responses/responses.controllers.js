(function(){
	"use strict";

	angular
		.module(APP_NAME)
		.controller('ResponsesController', ResponsesController)
		.controller('CreateResponsesController', CreateResponsesController)
		.controller('UpdateResponsesController', UpdateResponsesController);

	ResponsesController.$inject = ['$routeParams', 'RedirectService', 'Response', 'Question', 'MessageService'];

	function ResponsesController($routeParams, RedirectService, Response, Question, MessageService) {
		var vm 			= this;
		vm.question_id 	= $routeParams.question_id;
		vm.question 		= Question.show({id: vm.question_id});
		vm.responses 		= Response.get({id: vm.question_id});
		vm.c_delete		= c_delete;

		function c_delete(id) {
			var response 	= new Response();
			response.id 	= id;
			response.$remove({id: id}, function(success) {
				MessageService.sendMessage('response.deleted.success');
               			RedirectService.redirect("/responses/" + vm.question_id);
			}, function(error){
				MessageService.sendMessage('response.deleted.error');
               			RedirectService.redirect("/responses/" + vm.question_id);
			});
		}
	}

	CreateResponsesController.$inject = ['$routeParams', 'RedirectService', 'MessageService', 'Response', 'Question', 'lodash'];

	function CreateResponsesController($routeParams, RedirectService, MessageService, Response, Question, lodash) {
		var vm		   		= this;
		vm.question_id 		= $routeParams.question_id;
		Question.show({id: vm.question_id}, function(data){
							vm.choices = data.choices;
							vm.keys = lodash.fill(Array(vm.choices.length), false);
							vm.question = data.question;
						});
		vm.response 			= new Response();
		vm.createResponse 		= createResponse;
		vm.response.text		= "";

		function createResponse() {
			vm.response.$save({"choices[]": vm.keys, question_id: vm.question_id}, function(success){
				 MessageService.sendMessage('response.created.success');
               			 RedirectService.redirect("/responses/" + vm.question_id);
			}, function(error){
				 MessageService.sendMessage('role.response.error');
               			 RedirectService.redirect("/responses/" + vm.question_id);
			});
		}
	}

	UpdateResponsesController.$inject = ['$routeParams', 'RedirectService', 'MessageService', 'Response', 'Question', 'lodash'];

	function UpdateResponsesController($routeParams, RedirectService, MessageService, Response, Question, lodash) {
		var vm		   		= this;
		vm.response_id 		= $routeParams.response_id;
		vm.updateResponse 		= updateResponse;
		Response.show({id: vm.response_id}, function(data) {
			if(data.question.style == 'choice') {
				vm.keys = data.keys;
				vm.choices = data.choices;
			}
			vm.question = data.question;
			vm.response = data.response;
		});
		function updateResponse() {
			Response.update({choices: vm.keys, question_id: vm.question_id, response: vm.response}, function(success){
				MessageService.sendMessage('response.updated.success');
				RedirectService.redirect("/responses/" + vm.question.id);
			}, function(error){
				MessageService.sendMessage('response.updated.error');
				RedirectService.redirect("/responses/" + vm.question.id);
			});
		}
	}
})();