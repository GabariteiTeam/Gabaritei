// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Permission', Permission);

    Permission.$inject = ['$resource'];

    function Permission($resource) {
        return $resource('permissions/:id.json');
    }

})();