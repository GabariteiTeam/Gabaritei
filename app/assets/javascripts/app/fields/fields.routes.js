(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(FieldsRoutes);

    function FieldsRoutes($routeProvider) {
        $routeProvider
            .when('/fields/:id', {
                templateUrl: 'templates/fields/index.html',
                controller: 'FieldsController',
                controllerAs: 'Ctrl'
            })
            .when('/fields/update/:id/:subject_id', {
                templateUrl: 'templates/fields/update.html',
                controller: 'FieldsUpdateController',
                controllerAs: 'Ctrl'
            })
            .when('/subjects/new/:subject_id', {
                templateUrl: 'templates/fields/new.html',
                controller: 'FieldsCreateController',
                controllerAs: 'Ctrl'
            })
            .otherwise({
                redirectTo: "subjects/"
            });
    }

})();
