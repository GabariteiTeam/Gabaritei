(function(){
	'use strict';
	angular
		.module(APP_NAME)
		.factory('ModalService', ModalService);

	ModalService.$inject = ['Modal', '$translate', '$modal'];

	function ModalService(Modal, $translate, $modal) {
		var triggerController;
		var modalList = {
			'subjects.confirm_delete_questions': {
				'title': 'crud.subjects.modal.delete_with_questions.title',
				'body': 'crud.subjects.modal.delete_with_questions.body'
			},
			'subjects.confirm_delete': {
				'title': 'crud.subjects.modal.delete.title',
				'body': 'crud.subjects.modal.delete.body'
			}
		};

		function registerModalController(callback) {
			triggerController = callback;
		}

		function alert(modal) {
			$translate([modal.title, modal.body], function(translations) {
				if(triggerController !== undefined) {
					if(modal.title !== undefined && modal.body !== undefined && modal.confirmCallback !== undefined) {
						triggerController(modal);
					}
				}
			});
		}
		function customModal(modalid, callback, pack) {
			$translate([modalList[modalid].title, modalList[modalid].body]).then(function (translations) {
				var modal = $modal({templateUrl: 'templates/modal/yes.no.modal.tpl.html',
									title: translations[modalList[modalid].title], 
									content: translations[modalList[modalid].body], 
									show: true
									});
				modal.$scope.modal = new Modal();
				modal.$scope.modal.confirmCallback = callback;
				modal.$scope.modal.pack = pack;
			});
		}

		return {
			alert: alert,
			registerModalController: registerModalController,
			customModal: customModal
		}
	}

})();