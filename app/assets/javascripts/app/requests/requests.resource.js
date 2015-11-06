(function() {

    angular
        .module(APP_NAME)
        .factory('RegistrationRequest', RegistrationRequest)
        .factory('CourseRegistrationRequest', CourseRegistrationRequest);

    RegistrationRequest.$inject = ['$resource'];

    function RegistrationRequest($resource) {
        return $resource('requests/:id/registration.json', {id: '@id'}, {
            assess: { method: 'PUT' }
        });
    }

    CourseRegistrationRequest.$inject = ['$resource'];

    function CourseRegistrationRequest($resource) {
        return $resource('requests/:id/course.json', {id: '@id'}, {
            assess: { method: 'PUT' }
        });
    }

})();
