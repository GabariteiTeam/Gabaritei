(function(){
	"use strict"
	angular
		.module(APP_NAME)
		.directive("gabConfirmModal", gabConfirmModal)
		.directive("gabShowModalButton", gabShowModalButton);

	function gabShowModalButton() {

		modalController.$inject = ['$scope', 'ModalService'];

		function modalController($scope, ModalService) {
			$scope.storeAndGo = storeAndGo;
			function storeAndGo() {
				ModalService.setArgs($scope.args);
			}
		}

		return {
			scope: {
				modalid: "@",
				args: "=", 
				class: "@",
				text: "@",
				icon: "@"
			},
			controller: modalController,
			replace: true,
			transclude: false,
			template: '<button type="button" ng-click="storeAndGo()"'    +
					  ' data-toggle="modal" data-target="#{{modalid}}"'  +
					  ' class={{class}}><span class="{{icon}}"></span>'  +
					  ' <span class="hidden-xs hidden-sm">&nbsp;</span>' + 
					  ' <span class="hidden-xs hidden-sm" translate>{{text}}</span></button>'

		}
	}
	
	function gabConfirmModal() {

		modalController.$inject = ['$scope', 'ModalService'];

		function modalController($scope, ModalService) {
			$scope.click_handler = function() {
				jQuery("#" + $scope.modalid).modal('hide');
				jQuery('body').removeClass('modal-open');
				jQuery('.modal-backdrop').remove();
				$scope.callback({id: ModalService.getArgs()});
			};
		}

		return {
			scope: {
				modalid: '@',
				title: '@',
				body: '@',
				callback: '&',
				args: '='
			},
			controller: modalController,
			templateUrl: 'templates/modal/confirm-modal.html'
		};
	}

})();