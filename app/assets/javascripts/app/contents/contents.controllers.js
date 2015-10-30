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
            '$sce',
            'Content',
            'Subject',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function ContentsController($location, $routeParams, $route, $sce, Content, Subject, MessageService, RedirectService, ModalService) {

    	var vm = this;

        vm.createContent = createContent;
        vm.updateContent = updateContent;
        vm.c_delete = c_delete;
        vm.clearFile = clearFile;

        activate();

        function activate() {
            if ($routeParams.id === undefined) {
                vm.content = new Content();
                vm.content.medium = {
                    is_attachment: 'true'
                }
                Content.query(function(data) {
                    vm.contents = data;    
                });
            } else {
                vm.content = Content.get({id: $routeParams.id}, function() {
                    if (!vm.content.medium.is_attachment) {
                        vm.content.medium.reference = $sce.trustAsResourceUrl(vm.content.medium.reference);
                    }
                    vm.content.medium.is_attachment = vm.content.medium.is_attachment.toString();
                });
            }
            
        }

        function createContent() {
            vm.content.$save(function(data) {
                MessageService.sendMessage('content.created.success');
                RedirectService.redirect("/contents");
            }, function(data) {
                MessageService.sendMessage('content.created.error');
            });
        }

        function updateContent() {
            vm.content.$update(function() {
                MessageService.sendMessage('content.updated.success');
                RedirectService.redirect("/contents");
            },
            function(err) {
                MessageService.sendMessage('content.updated.error');
            });
        }

        function c_delete(id) {
            Content.delete({id: id}, function() {
                MessageService.sendMessage('content.deleted.success');
                RedirectService.redirect("/contents");
            },
            function(err) {
                MessageService.sendMessage('content.deleted.error');
            });
        }

        function clearFile() {
            vm.content.medium.data = null;
            vm.content.medium.data_file_name = null;
        }

    }

})();