(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(CourseRoutes);

    function CourseRoutes($routeProvider) {
        $routeProvider
            .when('/courses/new', {
                templateUrl: 'templates/courses/new.html',
                controller: 'CoursesController',
                controllerAs: 'Ctrl'
            })
            .when('/courses/update/:id', {
                templateUrl: 'templates/courses/update.html',
                controller: 'CoursesController',
                controllerAs: 'Ctrl'
            })
            .when('/courses/participants/:id', {
                templateUrl: 'templates/courses/participants.html',
                controller: 'CourseParticipantsController',
                controllerAs: 'Ctrl'
            })
            .when('/courses', {
                templateUrl: 'templates/courses/index.html',
                controller: 'CoursesController',
                controllerAs: 'Ctrl'
            })
            .when('/courses/:course_id/:resource/:id/recommend', {
                templateUrl: 'templates/recommendations/recommend.html',
                controller: 'RecommendationsController',
                controllerAs: 'Ctrl'
            });
    }

})();