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
            .when('/tests', {
                templateUrl: 'templates/tests/index.html',
                controller: 'TestsController',
                controllerAs: 'Ctrl'
            });
    }

})();
