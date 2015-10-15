(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('ContentsController', ContentsController);

 	ContentsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Content',
            'Subject',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function ContentsController($location, $routeParams, $route, Content, Subject, MessageService, RedirectService, ModalService) {

    	var vm = this;

    	vm.content = new Content();
    	vm.content.media = {
    		is_attachment: 'true'
    	}

    }

})();