(function(){
	angular
		.module(APP_NAME)
		.directive("gabConfirmModal", gabConfirmModal);

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