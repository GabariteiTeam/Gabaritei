// Services section

var subjectResourcer = angular.module('subjectResource',['ngResource']);
subjectResourcer.factory('Subject', ['$resource',
  function($resource){
    return $resource('subjects/:subject.json', {}, {
      query: {method:'GET', params:{}, isArray:true}
    });
  }]);

var dataImportResourcer = angular.module('dataImportResource',['ngResource']);
dataImportResourcer.factory('DataImport', ['$resource',
  function($resource){
    return $resource('data_import/:data_import.json', {}, {
      query: {method:'GET', params:{}, isArray:true}
    });
  }]);