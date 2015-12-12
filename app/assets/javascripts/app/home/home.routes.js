(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(HomeRoutes);

    HomeRoutes.$inject = ['$routeProvider'];

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

})();
