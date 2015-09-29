(function(){
	angular
		.module(APP_NAME)
		.directive("gabConfirmModal", gabConfirmModal);

	gabConfirmModalController.$inject = ['$scope'];

	function gabConfirmModalController($scope) {
		$scope.closeModal = closeModal;

		function closeModal() {
			$("#" + $scope.modalid).modal('hide');
		}
	}

	function gabConfirmModal() {
		return {
			controller: gabConfirmModalController,
			scope: {
				modalid: '@',
				title: '@',
				body: '@',
				callback: '&',
				args: '='
			},
			templateUrl: 'templates/modal/confirm-modal.html'
		};
	}

})();