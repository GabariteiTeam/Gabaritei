// This file will keep all the routes for our application
// for each controller we'll have one app module
// to keep things organized
//var homeRoutes = angular.module('homeRoutes', ['ngRoute', 'homeControllers', 'subjectControllers', 'DataImportCtrl']);

/**
* Routing for 'Home'
*/

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
            .when('/subjects', { 
                templateUrl: 'assets/partials/subjects/index.html',
                controller: 'SubjectController'
            });
    }

    function DataImportRoutes($routeProvider) {
        $routeProvider
            .when('/data_import', {
                templateUrl: 'assets/partials/data_import/index.html',
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
//         //controller: 'homeController'
//         controller: 'HomeController'
//       }).otherwise({
//         redirectTo: '/home'
//       });
//   }]);


/**
* Routing for 'Subjects'
*/
// var subjectsRoutes = angular.module('subjectsRoutes', ['ngRoute']);

// homeRoutes.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/subjects', { 
//         templateUrl: 'assets/partials/subjects/index.html',
//         //controller: 'subjectController'
//         controller: 'SubjectController'
//       });
//   }]);

/**
* Routing for 'Data import'
*/
// homeRoutes.config(['$routeProvider',
//   function($routeProvider) {
//     $routeProvider.
//       when('/data_import', {
//         templateUrl: 'assets/partials/data_import/index.html',
//         //controller: 'DataImportCtrl'
//         controller: 'DataImportController'
//       });
//   }]);