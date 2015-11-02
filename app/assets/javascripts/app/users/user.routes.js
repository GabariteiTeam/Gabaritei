(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .factory('editUserPrepService', editUserPrepService)
        .config(UserRoutes);

    function UserRoutes($routeProvider) {
        $routeProvider
            .when('/users/new', {
                templateUrl: 'templates/users/new.html',
                controller: 'EditUserController',
                controllerAs: 'Ctrl',
                resolve: {
                    usersPrepService: editUserPrepService,
                    rolesPrepService: rolesPrepService
                }
            })
            .when('/users/update/:id', {
                templateUrl: 'templates/users/update.html',
                controller: 'EditUserController',
                controllerAs: 'Ctrl',
                resolve: {
                    usersPrepService: editUserPrepService,
                    rolesPrepService: rolesPrepService
                }
            })
            .when('/users', {
                templateUrl: 'templates/users/index.html',
                controller: 'UsersController',
                controllerAs: 'Ctrl',
                resolve: {
                    usersPrepService: usersPrepService
                }
            })
            .when('/users/:id', {
                templateUrl: 'templates/users/show.html',
                controller: 'UsersController',
                controllerAs: 'Ctrl',
                resolve: {
                    usersPrepService: usersPrepService
                }
            });
    }

    usersPrepService.$inject = ['$route', 'User'];
    function usersPrepService($route, User) {
        if ($route.current.params.id !== undefined) return User.get({id: $route.current.params.id}, function(user) {
            if (user.about = "null") user.about = "";
        });
        else return User.query();
    }

    rolesPrepService.$inject = ['$route', 'Role'];
    function rolesPrepService($route, Role) {
        return Role.query();
    }

    editUserPrepService.$inject = ['$route', 'User'];
    function editUserPrepService($route, User) {
        if ($route.current.params.id !== undefined) return User.get({id: $route.current.params.id}, function(user) {
            user.birthdate = user.birthdate ? new Date(user.birthdate) : null;
            if (user.about = "null") user.about = "";
            if (!user.has_avatar) user.avatar = null;
        });
        else return new User();
    }

})();