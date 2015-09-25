(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(RoleRoutes);

    function RoleRoutes($routeProvider) {
        $routeProvider
            .when('/roles/new', {
                templateUrl: 'templates/roles/new.html',
                controller: 'RolesController',
                controllerAs: 'Ctrl'
            })
            .when('/roles/update/:id', {
                templateUrl: 'templates/roles/update.html',
                controller: 'RolesController',
                controllerAs: 'Ctrl'
            })
            .when('/roles', {
                templateUrl: 'templates/roles/index.html',
                controller: 'RolesController',
                controllerAs: 'Ctrl'
            })
    }

})();