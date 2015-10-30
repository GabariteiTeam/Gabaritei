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

        vm.createContent = createContent;

        activate();

        function activate() {
            vm.content = new Content();
            vm.content.medium = {
                is_attachment: 'true'
            }
            Content.query(function(data) {
                vm.contents = data;    
            });
        }

        function createContent() {
            if (vm.content.medium.is_attachment == 'true') {
                vm.content.upload(function(data) {
                    MessageService.sendMessage('content.created.success');
                    RedirectService.redirect("/contents");
                }, function(data) {
                    MessageService.sendMessage('content.created.error');
                });
            } else {
                vm.content.$save(function(data) {
                    MessageService.sendMessage('content.created.success');
                    RedirectService.redirect("/contents");
                }, function(data) {
                    MessageService.sendMessage('content.created.error');
                });
            }
        }

    }

})();