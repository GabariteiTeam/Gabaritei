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
            '$scope',
            '$timeout',
            '$activityIndicator',
            'MessageService',
            'DataImport',
            'Role'
        ];

    function DataImportsController($scope, $timeout, $activityIndicator, MessageService, DataImport, Role) {

        var vm = this;

        vm.refresh = refresh;
        vm.uploadFile = uploadFile;
        vm.importData = importData;
        vm.deleteFile = deleteFile;
        vm.editFile = editFile;
        vm.updateFile = updateFile;
        vm.cancelFileUpdate = cancelFileUpdate;
        vm.show_file_parameters = false;
        vm.data_imports = [];
        vm.models = ['Users', 'Subjects and Fields', 'Courses'];
        vm.data_import = new DataImport();
        vm.data_import.col_sep = ",";
        vm.data_import.model = '0';
        vm.data_import.file = null;
        vm.pollingPeriod = 3000;
        vm.fileUpload = {
            uploading: false,
            progress: 0
        };
        Role.query(function(data) {
            vm.user_roles = data;
            if (vm.user_roles.length > 0) vm.data_import.role = vm.user_roles[0].id;
            vm.refresh();
        }, function(data) {
            vm.refresh();
        });
        
        $scope.$watch('Ctrl.data_import.file', uploadFile);

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
                for (var i = 0; i < vm.data_imports.length; i++) {
                    vm.data_imports[i].model = vm.data_imports[i].model.toString();
                    if (vm.data_imports[i].model != '0') {
                        vm.data_imports[i].role = {
                            id: vm.user_roles[0].id
                        }
                    }
                }
                var statusProduct = 1;
                for (var i = 0; i < data.length; i++) statusProduct *= data[i].status;
                if (statusProduct == 0) {
                    $timeout(vm.refresh, vm.pollingPeriod);
                    if (!$activityIndicator.isAnimating()) $activityIndicator.startAnimating();
                }
                else {
                    if ($activityIndicator.isAnimating()) $activityIndicator.stopAnimating();
                }
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
            if (vm.data_import.file) {
                vm.fileUpload.uploading = true;
                vm.data_import.upload(function(data) {
                    vm.fileUpload.uploading = false;
                    MessageService.sendMessage("Uploaded!", "File was uploaded with success!", "success");
                    vm.data_import.file = null;
                    vm.refresh();
                }, function(data) {
                    vm.fileUpload.uploading = false;
                    MessageService.sendMessage("Error!", "File could not be uploaded!", "error");
                    vm.data_import.file = null;
                });
            }
        }

        function importData(data_import_id) {
            DataImport.import({
                id: data_import_id
            }, {
                id: data_import_id
            }, function(data) {
                vm.refresh();
            });
        }

        function deleteFile(data_import_id) {
            DataImport.delete({
                id: data_import_id
            }, function(data) {
                MessageService.sendMessage("Deleted!", "File was deleted with success!", "success");
                vm.refresh();
            }, function(data) {
                MessageService.sendMessage("Error!", "File could not be deleted!", "error");
            });
        }

        function editFile(elem) {
            elem.edit = true;
        }

        function updateFile(elem) {
            elem.$update(function(data) {
                MessageService.sendMessage("Updated!", "File was updated with success!", "success");
                vm.refresh();
            }, function(err) {
                MessageService.sendMessage("Error!", "File could not be updated!", "error");
                vm.refresh();
            });
        }

        function cancelFileUpdate(elem) {
            elem.edit = false;
            vm.refresh();
        }

    };

})();
