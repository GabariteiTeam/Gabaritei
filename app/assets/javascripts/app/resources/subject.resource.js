// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Subject', Subject);

    Subject.$inject = ['$resource'];

    function Subject($resource) {
        return $resource('subjects/:id', {}, {
          // query: {method:'GET', params:{id: ''}, isArray:true},
          // get: {method:'GET', params:{id: ''}},
          // save: {method: 'POST'},
          update: {method: 'PUT'}
          // destroy: {method: 'DELETE', params:{id: ''}}
        });
    }
 
})();