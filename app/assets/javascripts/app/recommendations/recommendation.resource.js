(function() {

    angular
        .module(APP_NAME)
        .factory('Recommendation', Recommendation);

    Recommendation.$inject = ['$resource'];

    function Recommendation($resource) {
        return $resource('recommendations/:id.json', {id: '@id'}, {
        	searchUsers: {
        		url: 'recommendations/search_users',
        		method: 'GET',
        		isArray: true
        	},
            recommend: {
                url: 'recommendations/recommend',
                method: 'POST'
            }
        });
    }

})();