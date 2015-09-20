(function(){
	'use strict';
	angular
        .module(APP_NAME)
        .controller('ModalController', ModalController);

    ModalController.$inject = ["ModalService", "Modal"];

    function ModalController(ModalService, Modal) {
    	var vm = this;

    	ModalService.registerModalController(showModal);

    	function showModal(modal) {
    		vm.modal = modal;
    		$('#modalBox').modal();
    	}
    }
})();