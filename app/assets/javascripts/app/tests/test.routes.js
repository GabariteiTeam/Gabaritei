(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(TestRoutes);

    function TestRoutes($routeProvider) {
        $routeProvider
            .when('/tests/new', {
                templateUrl: 'templates/tests/new.html',
                controller: 'TestsController',
                controllerAs: 'Ctrl'
            })
            .when('/tests/update/:id', {
                templateUrl: 'templates/tests/update.html',
                controller: 'TestsController',
                controllerAs: 'Ctrl'
            })
            .when('/tests/questions/:id', {
                templateUrl: 'templates/tests/questions.html',
                controller: 'TestQuestionsController',
                controllerAs: 'Ctrl'
            })
            .when('/tests', {
                templateUrl: 'templates/tests/index.html',
                controller: 'TestsController',
                controllerAs: 'Ctrl'
            })
            .when('/tests/:id', {
                templateUrl: 'templates/tests/show.html',
                controller: 'TestsController',
                controllerAs: 'Ctrl'
            })
            .when("/tests/:id/start/", {
                templateUrl: 'templates/tests/test.html',
                controller: 'TestsStartController',
                controllerAs: 'Ctrl'
            })
            .when("/tests/:id/response", {
                templateUrl: 'templates/tests/response.html',
                controller: 'TestsResponsesController',
                controllerAs: 'Ctrl'
            });
    }

})();
