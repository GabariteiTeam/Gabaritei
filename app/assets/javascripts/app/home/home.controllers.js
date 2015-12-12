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

    HomeController.$inject = ['$scope', 'HomeDataSource', 'Auth', 'RedirectService'];

    function HomeController($scope, HomeDataSource, Auth, RedirectService) {

        var vm = this;

        activate();

        function activate() {
            HomeDataSource.getHomeInfo().then(function(data) {
                vm.courses = data.courses;
            }, function(error) {

            });
        }
       
    }
    
})();
