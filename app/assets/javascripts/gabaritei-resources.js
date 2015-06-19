// Services section

var subjectResourcer = angular.module('subjectResource',['ngResource']);
subjectResourcer.factory('Subject', ['$resource',
  function($resource){
    return $resource('subjects/:subject.json', {}, {
      query: {method:'GET', params:{}, isArray:true}
    });
  }]);