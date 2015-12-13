(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(Translate);

    Translate.$inject = ['$translateProvider'];

    function Translate($translateProvider) {
        $translateProvider.useStaticFilesLoader({
            prefix: 'translations/',
            suffix: '.json'
        });
        $translateProvider.preferredLanguage('en');
    }

})();
