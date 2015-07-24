// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Subject', Subject)
        .factory('Message', Message)
        .factory('DataImport', DataImport);

    Subject.$inject = ['$resource'];

    function Subject($resource) {
        return $resource('subjects/:id', {}, {
          query: {method:'GET', params:{id: ''}, isArray:true},
          get: {method:'GET', params:{id: ''}},
          save: {method: 'POST'},
          update: {method: 'PUT'},
          destroy: {method: 'DELETE', params:{id: ''}}
        });
    }

    Message.$inject = ['$resource'];

    function Message($resource) {
        return $resource();
    }

    DataImport.$inject = ['$http', '$resource', 'Upload'];

    function DataImport($http, $resource, Upload) {
        var di = $resource('/data_imports/:id.json', null, {
            update: {method: 'PUT'}
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

//var subjectResourcer = angular.module('subjectResource',['ngResource']);

// subjectResourcer.factory('Subject', ['$resource',
//   function($resource){
//     return $resource('subjects/:id', {}, {
//       query: {method:'GET', params:{id: ''}, isArray:true},
//       get: {method:'GET', params:{id: ''}},
//       save: {method: 'POST'},
//       update: {method: 'PUT'},
//       destroy: {method: 'DELETE', params:{id: ''}}
//     });
// }]);

// subjectResourcer.factory('Message', ['$resource',
//   function($resource){
//     return $resource();
// }]);