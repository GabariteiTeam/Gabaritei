// Resources

(function() {

    angular
        .module(APP_NAME)
        .factory('Field', Field);

    Field.$inject = ['$resource'];

    function Field($resource) {
        return $resource('fields/:id', {}, {
            save: {
                URL: "fields/", 
                method: 'POST'
            },
            get: {
                URL: 'fields/:id', 
                method: "GET",
                isArray: true
            },
            destroy: {
                URL: 'fields/:id',
                method: "DELETE"
            }
        });
    }

})();
