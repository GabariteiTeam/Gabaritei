(function(){
	'use strict';
	angular
		.module(APP_NAME)
		.factory('ModalService', ModalService);

	function ModalService() {
		var args;

		function setArgs(_args) {
			args = _args;
		}

		function getArgs() {
			return args;
		}

		return {
			setArgs: setArgs,
			getArgs: getArgs,
		}
	}

})();