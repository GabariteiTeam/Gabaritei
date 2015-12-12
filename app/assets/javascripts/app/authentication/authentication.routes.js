(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(AuthenticationRoutes);

    AuthenticationRoutes.$inject = ['$routeProvider'];

    function AuthenticationRoutes($routeProvider) {
        $routeProvider
            .when('/users/login', {
                templateUrl: 'templates/authentication/login.html',
                controller: 'AuthenticationController',
                controllerAs: 'Ctrl'
            })
            .when('/forgot_password', {
                templateUrl: 'templates/authentication/forgot_password.html',
                controller: 'ForgotPasswordController',
                controllerAs: 'Ctrl'
            })
            .when('/password_sent', {
                templateUrl: 'templates/authentication/password_sent.html',
                controller: 'AuthenticationController',
                controllerAs: 'Ctrl'
            });
    }

})();