/**
 * @ngdoc controller
 * @name gabariteiApp.controller:TranslationsController
 * @description
 * Translations controller
 */

(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('TranslationsController', TranslationsController);

    TranslationsController.$inject = ['$translate'];

    function TranslationsController($translate) {
    	var vm = this;
    	vm.changeLanguage = changeLanguage;

    	function changeLanguage(language_key) {
    		$translate.use(language_key);
    	}
    }

})();
