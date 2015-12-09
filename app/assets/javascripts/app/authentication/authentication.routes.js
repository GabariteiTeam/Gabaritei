(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(AuthenticationRoutes);

    function AuthenticationRoutes($routeProvider) {
        $routeProvider
            .when('/users/login', {
                templateUrl: 'templates/authentication/login.html',
                controller: 'AuthenticationController',
                controllerAs: 'Ctrl'
            });
    }

})();