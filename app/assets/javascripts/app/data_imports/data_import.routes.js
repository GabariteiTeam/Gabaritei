(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(DataImportRoutes);

    function DataImportRoutes($routeProvider) {
        $routeProvider
            .when('/data_imports', {
                templateUrl: 'templates/data_imports/index.html',
                controller: 'DataImportsController',
                controllerAs: 'Ctrl'
            });
    }

})();
