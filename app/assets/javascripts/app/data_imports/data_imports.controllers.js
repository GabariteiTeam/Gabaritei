/**
 * @ngdoc controller
 * @name gabariteiApp.controller:DataImportController
 * @requires gabariteiApp.service:DataImport
 * @description
 *
 * This controller manages the data import page.
 **/

(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('DataImportsController', DataImportsController);

    DataImportsController
        .$inject = [
            '$timeout',
            'DataImport'
        ];

    function DataImportsController($timeout, DataImport) {

        var vm = this;
        var pollingPeriod = 3000;

        vm.refresh = refresh;
        vm.uploadFile = uploadFile;
        vm.importData = importData;
        vm.deleteFile = deleteFile;
        vm.show_file_parameters = false;
        vm.data_imports = [];
        vm.models = [];
        vm.data_import = new DataImport();

        DataImport.models(function(data) {
            vm.models = data;
            vm.data_import.header = true;
            vm.data_import.model = "0";
            vm.data_import.col_sep = ";";
        });

        refresh();

        /**
         * @ngdoc method
         * @name refresh
         * @methodOf gabariteiApp.controller:DataImportController
         * @description
         *
         * Refreshes displayed data imports. If at least one of the data imports has the status "Currently being imported", this methods schedules its own further execution so as to update the status of the import process (progress bar).
         **/
        function refresh() {
            DataImport.query(function(data) {
                vm.data_imports = data;
                var statusProduct = 1;
                for (var i = 0; i < data.length; i++) statusProduct *= data[i].status;
                if (statusProduct == 0) $timeout(refresh, pollingPeriod);
            });
        }

        /**
         * @ngdoc method
         * @name uploadFile
         * @methodOf gabariteiApp.controller:DataImportController
         * @description
         *
         * upload file
         **/
        function uploadFile() {
            if (vm.data_import.file && vm.data_import.file.length && vm.data_import.model) {
                DataImport.upload(vm.data_import, function(data) {
                    refresh();
                });
            }
        }

        function importData(data_import_id) {
            DataImport.import({
                id: data_import_id
            }, {
                id: data_import_id
            }, function(data) {
                refresh();
            });
        }

        function deleteFile(data_import_id) {
            DataImport.delete({
                id: data_import_id
            }, function(data) {
                refresh();
            });
        }

    };

})();
