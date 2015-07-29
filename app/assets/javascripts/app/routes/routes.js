// This file will keep all the routes for our application
// for each controller we'll have one app module
// to keep things organized

(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(HomeRoutes)
        .config(SubjectRoutes)
        .config(DataImportRoutes);

    function HomeRoutes($routeProvider) {
        $routeProvider
            .when('/home', {
                templateUrl: 'templates/home/home.html',
                controller: 'HomeController'
            })
            .otherwise({
                redirectTo: '/home'
            });
    }

    function SubjectRoutes($routeProvider) {
        $routeProvider
            .when('/subjects/new', { 
                templateUrl: 'templates/subjects/new.html',
                controller: 'SubjectsController',
                controllerAs: 'Ctrl'
            })
            .when('/subjects/update/:id', {
                templateUrl: 'templates/subjects/update.html',
                controller: 'SubjectsController',
                controllerAs: 'Ctrl'
            })
            .when('/subjects', { 
                templateUrl: 'templates/subjects/index.html',
                controller: 'SubjectsController',
                controllerAs: 'Ctrl'
            })
    }

    function DataImportRoutes($routeProvider) {
        $routeProvider
            .when('/data_imports', {
                templateUrl: 'templates/data_imports/index.html',
                controller: 'DataImportsController',
                controllerAs: 'Ctrl'
            });
    }

})();
