(function(){
	'use strict';
	angular
		.module(APP_NAME)
		.factory('Modal', Modal);

	Modal.$inject = ['$resource'];

	function Modal($resource) {
		return $resource();
	}
})();