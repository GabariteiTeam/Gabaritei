// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Question', Question);

    Question.$inject = ['$resource'];

    function Question($resource) {
        return $resource('questions/:id', {}, {
          query: {method:'GET', params:{id: ''}, isArray:true},
          get: {method:'GET', params:{id: ''}},
          save: {method: 'POST'},
          update: {method: 'PUT'},
          destroy: {method: 'DELETE', params:{id: ''}}
        });
    }

})();
