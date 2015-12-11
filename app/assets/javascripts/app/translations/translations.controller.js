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
        vm.currentLanguage = currentLanguage;
        vm.languages = {
            'en': 'English',
            'pt-BR': 'Português'
        };

        function changeLanguage(language_key) {
            $translate.use(language_key);
        }

        function currentLanguage() {
            return $translate.use();
        }
    }

})();
