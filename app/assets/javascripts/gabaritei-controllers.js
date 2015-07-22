// We place here all the controllers

// var homeControllers = angular.module('homeControllers', [])
// homeControllers.controller('homeController', ['$scope', function($scope){
	
// }]);

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
        vm.data_imports = [];

        refresh();
        
        function refresh() {
            DataImport.query(function (data) {
                vm.data_imports = data;
                var statusProduct = 1;
                for (var i = 0; i < data.length; i++) statusProduct *= data[i].status;
                if (statusProduct == 0) $timeout(refresh, pollingPeriod);
            });
        }

        function uploadFile(data) {
            if (data.file && data.file.length && data.model) {
                DataImport.upload(data, function (data) {
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

    }

})();





//-----------------------------------------
//  SubjectController
//-----------------------------------------

// var subjectControllers = angular.module('subjectControllers', [])
// subjectControllers.controller('subjectController', ['$scope', 'Subject', function($scope, Subject){
//   $scope.subjects = [];
//   Subject.query(function (data){
//     $scope.subjects = data;
//   });
// }])



//-----------------------------------------
//  DataImportController
//-----------------------------------------



// var DataImportController = angular.module('DataImportController', [])
// DataImportController.controller('DataImportCtrl', ['$scope', '$route', '$http', '$timeout', 'DataImport', 'Upload', function($scope, $route, $http, $timeout, DataImport, Upload){
// 	$scope.data_imports = [];

//     (function() {
//         refresh();
//     })();

//     function refresh() {
//         DataImport.query(function (data) {
//             $scope.data_imports = data;
//             var statusProduct = 1;
//             for (i = 0; i < data.length; i++) {
//                 statusProduct *= data[i].status;
//             }
//             if (statusProduct == 0) {
//                 $timeout(refresh, 5000);
//             }
//         });
//     }

//     $scope.uploadFile = function (file) {
// 		if (file && file.length) {
// 			Upload.upload({
//                 url: 'data_imports/upload',
//                 fields: {'data_import[data_type]': $scope.data_type},
//                 file: file,
//                 fileFormDataName: 'data_import[data]'
//             }).progress(function (evt) {
                
//             }).success(function (data, status, headers, config) {
//                 refresh();
//             }).error(function (data, status, headers, config) {
//                 console.log('error status: ' + status);
//             })
// 		}
// 	};

//     $scope.importFile = function (data) {
//         $http.post('/data_imports/import', {
//             data_import_id: data.data_import.id
//         }).success(function(data, status, headers, config) {
//             refresh();
//         }).error(function(data, status, headers, config) {
   
//         });    
//     };

//     $scope.deleteFile = function (data) {
//         $http.post('/data_imports/delete', {
//             data_import_id: data.data_import.id
//         }).success(function(data, status, headers, config) {
//             refresh();
//         }).error(function(data, status, headers, config) {
   
//         });    
//     };


// }]);