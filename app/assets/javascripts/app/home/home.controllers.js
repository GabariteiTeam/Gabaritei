/**
 * @ngdoc controller
 * @name gabariteiApp.controller:HomeController
 * @description
 * Home page controller
 */

(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('HomeController', HomeController);

    HomeController.$inject = ['$scope', 'HomeDataSource', 'Auth', 'RedirectService', 'PermissionsService'];

    function HomeController($scope, HomeDataSource, Auth, RedirectService, PermissionsService) {

        var vm = this;

        activate();

        function activate() {
            HomeDataSource.getHomeInfo().then(function(data) {
                vm.courses = data.courses;
                PermissionsService.verifyPermissions(['permission.courses.globally_manipulate', 'permission.courses.manipulate', 'permission.courses.teach'], function(permissions) {
                    vm.permissions = permissions;
                });
            }, function(error) {

            });
        }
       
    }
    
})();
