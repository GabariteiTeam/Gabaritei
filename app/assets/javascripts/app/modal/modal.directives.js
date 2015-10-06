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
				callback: "&",
				args: "=", 
				class: "@",
				text: "@"
			},
			replace: true,
			transclude: false,
			template: '<button type="button" ng-click="callback(args)"' +
					' data-toggle="modal" data-target="#{{modalid}}"' +
					'class={{class}}> <span translate> {{text}} </span></button>'

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
			controller: ['$scope', 'ModalService', function($scope, ModalService){
				$scope.hey = function() {
					ModalService.alert();
				};
			}],
			templateUrl: 'templates/modal/confirm-modal.html'
		};
	}

})();