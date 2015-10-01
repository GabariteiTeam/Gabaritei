(function(){
	'use strict';
	angular
		.module(APP_NAME)
		.factory('ModalService', ModalService);

	function ModalService() {
		var callback;
		var args;

		function registerCallback(_callback) {
			callback = _callback;
		}

		function setArgs(_args) {
			args = _args;
		}

		function alert() {
			callback(args);
		}

		function hideModal() {
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();
		}
		

		return {
			alert: alert,
			setArgs: setArgs,
			registerCallback: registerCallback,
			hideModal: hideModal
		}
	}

})();