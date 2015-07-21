

var homeControllers = angular.module('homeControllers', [])
homeControllers.controller('homeController', ['$scope', function($scope){
	
}]);


var subjectControllers = angular.module('subjectControllers', [])
subjectControllers.controller('subjectController', ['$scope', 'Subject', function($scope, Subject){
  $scope.subjects = [];
  Subject.query(function (data){
    $scope.subjects = data;
  });
}])

var DataImportCtrl = angular.module('DataImportCtrl', [])
DataImportCtrl.controller('DataImportCtrl', ['$scope', '$route', '$http', '$timeout', 'DataImport', 'Upload', function($scope, $route, $http, $timeout, DataImport, Upload){
	$scope.data_imports = [];

    (function() {
        refresh();
    })();

    function refresh() {
        DataImport.query(function (data) {
            $scope.data_imports = data;
            var statusProduct = 1;
            for (i = 0; i < data.length; i++) {
                statusProduct *= data[i].status;
            }
            if (statusProduct == 0) {
                $timeout(refresh, 5000);
            }
        });
    }

    $scope.uploadFile = function (file) {
		if (file && file.length) {
			Upload.upload({
                url: 'data_import/upload',
                fields: {'data_import[data_type]': $scope.data_type},
                file: file,
                fileFormDataName: 'data_import[data]'
            }).progress(function (evt) {
                
            }).success(function (data, status, headers, config) {
                refresh();
            }).error(function (data, status, headers, config) {
                console.log('error status: ' + status);
            })
		}
	};

    $scope.importFile = function (data) {
        $http.post('/data_import/import', {
            data_import_id: data.data_import.id
        }).success(function(data, status, headers, config) {
            refresh();
        }).error(function(data, status, headers, config) {
   
        });    
    };

    $scope.deleteFile = function (data) {
        $http.post('/data_import/delete', {
            data_import_id: data.data_import.id
        }).success(function(data, status, headers, config) {
            refresh();
        }).error(function(data, status, headers, config) {
   
        });    
    };


}]);