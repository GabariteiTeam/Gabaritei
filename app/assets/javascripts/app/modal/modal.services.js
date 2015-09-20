(function(){
	'use strict';
	angular
		.module(APP_NAME)
		.factory('ModalService', ModalService);

	ModalService.$inject = ["Modal"];

	function ModalService(Modal) {
		var triggerController;

		function registerModalController(callback) {
			triggerController = callback;
		}

		function alert(modal) {
			if(triggerController !== undefined) {
				if(modal.title !== undefined && modal.body !== undefined && modal.confirmCallback !== undefined) {
					triggerController(modal);
				}
			}
		}

		return {
			alert: alert,
			registerModalController: registerModalController
		}
	}

})();