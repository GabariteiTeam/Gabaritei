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
            'MessageService',
            'DataImport',
            'Role'
        ];

    function DataImportsController($timeout, MessageService, DataImport, Role) {

        var vm = this;
        var pollingPeriod = 3000;

        vm.refresh = refresh;
        vm.uploadFile = uploadFile;
        vm.importData = importData;
        vm.deleteFile = deleteFile;
        vm.fileNameChanged = fileNameChanged;
        vm.show_file_parameters = false;
        vm.data_imports = [];
        vm.models = ['Users', 'Subjects and Fields', 'Courses'];
        vm.data_import = new DataImport();
        vm.data_import.col_sep = ",";
        vm.data_import.model = '0';
        vm.missingFile = false;
        vm.csv_file = false;
        Role.query(function(data) {
            vm.user_roles = data;
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
                vm.missingFile = false;
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
            vm.data_import.upload(function(data) {
                MessageService.sendMessage("Created!", "File was uploaded with success!", "success");
                refresh();
            }, function(data) {
                MessageService.sendMessage("Error!", "File could not be uploaded!", "error");
                vm.missingFile = true;
            });
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

        function fileNameChanged(element) {
            var file = element.files[0]; 
            vm.csv_file = (file !== undefined && file.type == "text/csv")
        }

    };

})();
