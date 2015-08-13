// This file will keep all the routes for our application
// for each controller we'll have one app module
// to keep things organized

(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(QuestionRoutes);

    function QuestionRoutes($routeProvider) {
        $routeProvider
            .when('/questions/new', {
                templateUrl: 'assets/partials/questions/new.html',
                controller: 'NewQuestionController',
                controllerAs: 'Ctrl'
            })
            .when('/questions', {
                templateUrl: 'assets/partials/questions/index.html',
                controller: 'QuestionsController',
                controllerAs: 'Ctrl'
            })
            .when('/questions/update/:id', {
                templateUrl: 'assets/partials/questions/update.html',
                controller: 'UpdateQuestionController',
                controllerAs: 'Ctrl'
            });
    }

})();
