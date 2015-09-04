// Resources

(function() {

    angular
        .module(APP_NAME)
        .factory('Field', Field);

    Field.$inject = ['$resource'];

    function Field($resource) {
        return $resource('fields/:id', {}, {
            save: {
                url: "fields/", 
                method: 'POST'
            },
            get: {
                url: 'fields/:id', 
                method: "GET",
                isArray: true
            },
            destroy: {
                url: 'fields/:id',
                method: "DELETE"
            },
            query: {
                url: '/field/:id/edit',
                method: "GET"
            },
            update: {
                url: '/fields/',
                method: 'PUT'
            }
        });
    }

})();
