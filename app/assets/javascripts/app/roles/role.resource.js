// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Role', Role);

    Role.$inject = ['$resource'];

    function Role($resource) {
        return $resource('roles/:id.json', {id: '@id'}, {
        	update: { method: 'PUT' },
        	rolesForCourses: { 
        		url: 'roles/roles_for_courses',
        		method: 'GET',
        		isArray: true
        	}
        });
    }

})();
