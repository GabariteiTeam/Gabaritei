(function(){
	"use strict";

	angular
		.module(APP_NAME)
		.config(ResponseRoutes);

	function ResponseRoutes($routeProvider) {
		$routeProvider
			.when('/responses/:question_id', {
				templateUrl: 'templates/responses/index.html',
				controller: 'ResponsesController',
				controllerAs: 'Ctrl'
			})
			.when('/responses/new/:question_id', {
				templateUrl: 'templates/responses/new.html',
				controller: 'CreateResponsesController',
				controllerAs: 'Ctrl'
			})
			.when('/responses/update/:response_id', {
				templateUrl: 'templates/responses/update.html',
				controller: 'UpdateResponsesController',
				controllerAs: 'Ctrl'
			});
	}
})();