// Services section

var subjectResourcer = angular.module('subjectResource',['ngResource']);

subjectResourcer.factory('Subject', ['$resource',
  function($resource){
    return $resource('subjects/:id', {}, {
      query: {method:'GET', params:{id: ''}, isArray:true},
      get: {method:'GET', params:{id: ''}},
      save: {method: 'POST'},
      update: {method: 'PUT'},
      destroy: {method: 'DELETE', params:{id: ''}}
    });
}]);

subjectResourcer.factory('Message', ['$resource',
  function($resource){
    return $resource();
}]);