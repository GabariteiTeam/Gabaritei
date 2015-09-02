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

    HomeController.$inject = ['MessageService', 'ModalService', 'Modal'];

    function HomeController() {
    }
})();
