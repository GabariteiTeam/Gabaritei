(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(RequestsRoutes);

    function RequestsRoutes($routeProvider) {
        $routeProvider
            .when('/requests', {
                templateUrl: 'templates/requests/index.html',
                controller: 'RequestsController',
                controllerAs: 'Ctrl'
            })
            .when('/requests/registration/new', {
                templateUrl: 'templates/requests/registration_new.html',
                controller: 'ManagementRequestsController',
                controllerAs: 'Ctrl',
                resolve: {
                    request: RegistrationRequestPrepService
                }
            })
            .when('/requests/course/new/:course_id', {
                templateUrl: 'templates/requests/course_registration_new.html',
                controller: 'ManagementRequestsController',
                controllerAs: 'Ctrl',
                resolve: {
                    request: CourseRegistrationRequestPrepService
                }
            })
            .when('/requests/registration/:id', {
                templateUrl: 'templates/requests/registration_assessment.html',
                controller: 'ManagementRequestsController',
                controllerAs: 'Ctrl',
                resolve: {
                    request: RegistrationRequestPrepService
                }
            })
            .when('/requests/course/:id', {
                templateUrl: 'templates/requests/course_registration_assessment.html',
                controller: 'ManagementRequestsController',
                controllerAs: 'Ctrl',
                resolve: {
                    request: CourseRegistrationRequestPrepService
                }
            });          
    }

    RegistrationRequestPrepService.$inject = ['$route', 'RegistrationRequest'];

    function RegistrationRequestPrepService($route, RegistrationRequest) {
        if ($route.current.params.id) {
            return RegistrationRequest.get({id: $route.current.params.id}, function(registration) {
                registration.birthdate = new Date(registration.birthdate);
            });
        } else {
            return new RegistrationRequest();
        }
    }

    CourseRegistrationRequestPrepService.$inject = ['$route', '$q', 'Auth', 'CourseRegistrationRequest'];

    function CourseRegistrationRequestPrepService($route, $q, Auth, CourseRegistrationRequest) {
        if ($route.current.params.id) {
            return CourseRegistrationRequest.get({id: $route.current.params.id});
        } else {
            return Auth.currentUser();
        }
    }


})();