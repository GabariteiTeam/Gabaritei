

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
DataImportCtrl.controller('DataImportCtrl', ['$scope', '$route', '$http', 'DataImport', 'Upload', function($scope, $route, $http, DataImport, Upload){
	$scope.data_imports = [];
    DataImport.query(function (data) {
        $scope.data_imports = data;
    });

    $scope.uploadFile = function (file) {
		if (file && file.length) {
			Upload.upload({
                url: 'data_import/upload',
                fields: {'data_import[data_type]': $scope.data_type},
                file: file,
                fileFormDataName: 'data_import[data]'
            }).progress(function (evt) {
                
            }).success(function (data, status, headers, config) {
                $route.reload();
            }).error(function (data, status, headers, config) {
                console.log('error status: ' + status);
            })
		}
	};

    $scope.importFile = function (data) {
        $http.post('/data_import/import', {
            data_import_id: data.data_import.id
        }).success(function(data, status, headers, config) {
            $route.reload();
        }).error(function(data, status, headers, config) {
   
        });    
    };
}]);