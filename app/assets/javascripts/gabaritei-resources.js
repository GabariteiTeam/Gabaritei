// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Subject', Subject)
        .factory('DataImport', DataImport);

    Subject.$inject = ['$resource'];

    function Subject($resource) {

        return $resource('subjects/:subject.json', {}, {
          query: {method:'GET', params:{}, isArray:true}
        });   
    }

    DataImport.$inject = ['$http', '$resource', 'Upload'];

    function DataImport($http, $resource, Upload) {
        var di = $resource('/data_imports/:id.json', null, {
            update: { 
                method: 'PUT'
            }
        });
        di.upload = function (params, success, error) {
            Upload.upload({
                url: '/data_imports',
                fields: {'data_import[model]': params.model},
                file: params.file,
                fileFormDataName: 'data_import[data]'
            })
            .progress(function (evt) {
                
            })
            .success(function (data) {
                if (success) success(data);
            })
            .error(function (data) {
                if (error) error(data);
            }); 
        }
        di.models = function(success, error) {
            $http.get('/data_imports/models')
                .success(function (data) {
                    if (success) success(data);
                })
                .error(function (data) {
                    if (error) error(data);
                }); 
        }

        return di;                
    }
     
})();

// var subjectResourcer = angular.module('subjectResource',['ngResource']);
// subjectResourcer.factory('Subject', ['$resource',
//   function($resource){
//     return $resource('subjects/:subject.json', {}, {
//       query: {method:'GET', params:{}, isArray:true}
//     });
//   }]);

// var dataImportResourcer = angular.module('dataImportResource',['ngResource']);
// dataImportResourcer.factory('DataImport', ['$resource',
//   function($resource){
//     return $resource('data_imports/:data_import.json', {}, {
//       query: {method:'GET', params:{}, isArray:true}
//     });
//   }]);