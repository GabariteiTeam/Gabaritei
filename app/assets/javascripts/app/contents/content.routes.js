(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(ContentRoutes);

    ContentRoutes.$inject = ['$routeProvider'];

    function ContentRoutes($routeProvider) {
        $routeProvider
            .when('/contents/new', {
                templateUrl: 'templates/contents/new.html',
                controller: 'ContentsController',
                controllerAs: 'Ctrl'
            })
            .when('/contents/update/:id', {
                templateUrl: 'templates/contents/update.html',
                controller: 'ContentsController',
                controllerAs: 'Ctrl'
            })
            .when('/contents', {
                templateUrl: 'templates/contents/index.html',
                controller: 'ContentsController',
                controllerAs: 'Ctrl'
            })
            .when('/contents/show/:id', {
                templateUrl: 'templates/contents/show.html',
                controller: 'ContentsController',
                controllerAs: 'Ctrl'
            })
            .when('/:resource/recommend/:id', {
                templateUrl: 'templates/recommendations/recommend.html',
                controller: 'RecommendationsController',
                controllerAs: 'Ctrl'
            });
    }

})();