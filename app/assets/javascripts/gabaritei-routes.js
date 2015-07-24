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
                templateUrl: 'assets/partials/home/home.html',
                controller: 'HomeController'
            })
            .otherwise({
                redirectTo: '/home'
            });
    }

    function SubjectRoutes($routeProvider) {
        $routeProvider
            .when('/subjects/new', { 
                templateUrl: 'assets/partials/subjects/new.html',
                controller: 'SubjectController',
                controllerAs: 'Ctrl'
            })
            .when('/subjects/update/:id', {
                templateUrl: 'assets/partials/subjects/update.html',
                controller: 'SubjectController',
                controllerAs: 'Ctrl'
            })
            .when('/subjects', { 
                templateUrl: 'assets/partials/subjects/index.html',
                controller: 'SubjectController',
                controllerAs: 'Ctrl'
            })
    }

    function DataImportRoutes($routeProvider) {
        $routeProvider
            .when('/data_import', {
                templateUrl: 'assets/partials/data_import/index.html',
                controller: 'DataImportController',
                controllerAs: 'Ctrl'
            })
            .when('/data_import/form.html', {
                templateUrl: 'assets/partials/data_import/_form.html',
                controller: 'DataImportController',
                controllerAs: 'Ctrl'
            });
    }

})();

// homeRoutes.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/home', {
//         templateUrl: 'assets/partials/home/home.html',
//         controller: 'homeController'
//       });
//   }]);

// var subjectsRoutes = angular.module('subjectsRoutes', ['ngRoute']);

// homeRoutes.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/subjects/new', { 
//         templateUrl: 'assets/partials/subjects/new.html',
//         controller: 'subjectController'
//       })
//       .when('/subjects/update/:id', {
//         templateUrl: 'assets/partials/subjects/update.html',
//         controller: 'subjectController'
//       })
//       .when('/subjects', { 
//         templateUrl: 'assets/partials/subjects/index.html',
//         controller: 'subjectController'
//       })
//   }]);
