(function(){
	"use strict";

	angular
		.module(APP_NAME)
		.factory('Response', Response);

	Response.$inject = ['$resource'];
      function Response($resource) {
        return $resource('/responses/:id.json', {id: '@id'}, {
        	get: {method: "GET", isArray: true},
        	show: {method: 'GET', url: '/responses/:id/show'},
             update: {method: 'PUT'}
        });
    }
})();