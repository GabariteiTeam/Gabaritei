(function() {

    angular
        .module(APP_NAME)
        .factory('Rating', Rating);

    Rating.$inject = ['$resource'];

    function Rating($resource) {
        return $resource('ratings/:id.json', {id: '@id'});
    }

})();