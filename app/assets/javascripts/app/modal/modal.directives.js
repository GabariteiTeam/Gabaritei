(function(){
	"use strict"
	angular
		.module(APP_NAME)
		.directive("gabConfirmModal", gabConfirmModal)
		.directive("gabShowModalButton", gabShowModalButton);

	function gabShowModalButton() {
		return {
			scope: {
				modalid: "@",
				args: "=", 
				class: "@",
				text: "@",
				icon: "@"
			},
			controller:function($scope, ModalService) {
				$scope.storeAndGo = storeAndGo;
				function storeAndGo() {
					ModalService.setArgs($scope.args);
				}
			},
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
		return {
			scope: {
				modalid: '@',
				title: '@',
				body: '@',
				callback: '&',
				args: '='
			},
			controller:function($scope, ModalService){
				$scope.click_handler = function() {
					jQuery("#" + $scope.modalid).modal('hide');
					jQuery('body').removeClass('modal-open');
					jQuery('.modal-backdrop').remove();
					$scope.callback({id: ModalService.getArgs()});
				};
			},
			templateUrl: 'templates/modal/confirm-modal.html'
		};
	}

})();