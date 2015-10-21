// Services section

(function() {

    angular
        .module(APP_NAME)
        .factory('Test', Test);

    Test.$inject = ['$resource'];

    function Test($resource) {
        return $resource('tests/:id', {}, {
            queryNames: {
                URL: "tests/names", 
                method: 'GET', 
                isArray: true
            },
            query: {
                method: 'GET',
                params: {
                    id: ''
                },
                isArray: true
            },
            get: {
                method: 'GET',
                params: {
                    id: ''
                }
            },
            save: {
                method: 'POST'
            },
            update: {
                method: 'PUT'
            },
            destroy: {
                method: 'DELETE',
                params: {
                    id: ''
                }
            },
            validateDestroy: {
                url: 'tests/validate/destroy/:id',
                method: 'GET',
                params: {
                    id: ''
                }
            }
        });
    }

})();
