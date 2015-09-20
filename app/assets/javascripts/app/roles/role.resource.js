// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Role', Role);

    Role.$inject = ['$resource'];

    function Role($resource) {
        return $resource('roles/:id.json', {id: '@id'}, {
        	update: { method: 'PUT' },
        	validateDestroy: {
                url: 'roles/:id/validate/destroy',
                method: 'GET'
            }
        });
    }

})();
