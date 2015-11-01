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

    HomeController.$inject = ['$scope', 'Auth', 'RedirectService'];

    function HomeController($scope, Auth, RedirectService) {

        Auth.currentUser().then(function(user) {
            
        }, function(error) {
            RedirectService.redirect("/users/login");
        });
       
    }
    
})();
