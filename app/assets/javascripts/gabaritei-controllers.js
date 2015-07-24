// We place here all the controllers

(function() {

    'use strict';

    //-----------------------------------------//
    //  Controllers declaration                //
    //-----------------------------------------//

    angular
        .module(APP_NAME)
        .controller('HomeController', HomeController)
        .controller('SubjectController', SubjectController)
        .controller('DataImportController', DataImportController);

    //-----------------------------------------//
    //  HomeController                         //
    //-----------------------------------------//

    function HomeController() {
    
    };

    //-----------------------------------------//
    //  SubjectController                      //
    //-----------------------------------------//

    SubjectController.$inject =['Subject'];

    function SubjectController(Subject) {
        var vm = this;
        vm.subjects = [];
        Subject.query(function (data){
            vm.subjects = data;
        });
    };

    //-----------------------------------------//
    //  DataImportController                   //
    //-----------------------------------------//

    DataImportController.$inject = ['$timeout', 'DataImport'];
    
    function DataImportController($timeout, DataImport) {
    
        var vm = this;
        var pollingPeriod = 3000;

        vm.refresh = refresh;
        vm.uploadFile = uploadFile;
        vm.importData = importData;
        vm.deleteFile = deleteFile;
        vm.selectFile = selectFile;
        vm.show_file_parameters = false;
        vm.data_imports = [];
        vm.models = [];
        vm.data_import = {};
    
        DataImport.models(function (data) {
            vm.models = data;
            vm.data_import = {
                model: "0"
            }
        });
       
        refresh();
        
        function refresh() {
            DataImport.query(function (data) {
                vm.data_imports = data;
                var statusProduct = 1;
                for (var i = 0; i < data.length; i++) statusProduct *= data[i].status;
                if (statusProduct == 0) $timeout(refresh, pollingPeriod);
            });
        }

        function uploadFile() {
            if (vm.data_import.file && vm.data_import.file.length && vm.data_import.model) {
                DataImport.upload(vm.data_import, function (data) {
                    refresh();
                });
            }
        };

        function importData (data_import_id) {
            DataImport.update({id: data_import_id}, {id: data_import_id}, function (data) {
                refresh();
            });
        };

        function deleteFile (data_import_id) {
            DataImport.delete({id: data_import_id}, function (data) {
                refresh();
            });
        };

        function selectFile () {
            vm.show_file_parameters = true;
        }

    }

})();