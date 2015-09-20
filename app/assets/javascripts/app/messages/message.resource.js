// Services section

(function() {
	'use strict';
    angular
        .module(APP_NAME)
        .factory('Message', Message);

    Message.$inject = ['$resource'];

    function Message($resource) {
        return $resource();
    }

})();
