(function() {

    angular
        .module(APP_NAME)
        .factory('Content', Content);

    Content.$inject = ['$resource'];

    function Content($resource) {
        return $resource('contents/:id.json', {id: '@id'});
    }

})();