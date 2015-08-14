(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(SubjectRoutes);

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

})();