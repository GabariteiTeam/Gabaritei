(function() {

    angular
        .module(APP_NAME)
        .factory('Course', Course);

    Course.$inject = ['$resource'];

    function Course($resource) {
        return $resource('courses/:id.json', {id: '@id'}, {
        	update: { method: 'PUT' }
        });
    }

})();