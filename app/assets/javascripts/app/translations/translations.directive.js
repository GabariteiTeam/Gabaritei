(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(Translate);

    function Translate($translateProvider) {
        $translateProvider.useStaticFilesLoader({
            prefix: 'translations/',
            suffix: '.json'
        });
        $translateProvider.preferredLanguage('en');
    }

})();
