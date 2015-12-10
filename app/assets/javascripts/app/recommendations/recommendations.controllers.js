(function() {
    
    'use strict';

    angular
        .module(APP_NAME)
        .controller('RecommendationsController', RecommendationsController);

    RecommendationsController.$inject = ['$routeParams', 'Recommendation', 'Course', 'Content', 'Question', 'MessageService'];

    function RecommendationsController($routeParams, Recommendation, Course, Content, Question, MessageService) {

    	var vm = this;

    	vm.loadUsers = loadUsers;
    	vm.createRecommendation = createRecommendation;

    	activate();

    	function activate() {
    		vm.course = Course.get({id: $routeParams.course_id}, function() {
    			vm.course_name = vm.course.name;
    		});
			if ($routeParams.resource == "content") {
				vm.content = Content.get({id: $routeParams.id}, function() {
					vm.content_title = vm.content.name;
					vm.content_description = vm.content.description;
					vm.resource = vm.content;
					vm.category = vm.content.category.name;
				});
	    	} else if ($routeParams.resource == "question") {
	    		Question.show({id: $routeParams.id}, function(question) {
	    			vm.question = question.question;
					vm.question_text = vm.question.text;
					vm.category = question.category_list;
					vm.resource = vm.question;
				});
	    	}  		
    	}

    	function loadUsers(query) {
    		return Recommendation.searchUsers({course_id: vm.course.id, query: query}).$promise;
    	}

    	function createRecommendation() {
    		Recommendation.recommend({course_id: vm.course.id, resource: vm.resource, targets: vm.to_whom, type: $routeParams.resource}, function(success) {
    			MessageService.sendMessage('recommendation.created.success');
    		}, function(error) {
    			MessageService.sendMessage('recommendation.created.error');
    		});
    	}

    }

})();