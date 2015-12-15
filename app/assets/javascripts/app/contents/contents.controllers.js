(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('ContentsController', ContentsController);

 	ContentsController.$inject = ['$routeParams', '$sce', 'Content', 'Subject', 'Course', 'MessageService', 'RedirectService', 'ModalService', 'PermissionsService'];

    function ContentsController($routeParams, $sce, Content, Subject, Course, MessageService, RedirectService, ModalService, PermissionsService) {

    	var vm = this;

        vm.createContent = createContent;
        vm.updateContent = updateContent;
        vm.c_delete = c_delete;
        vm.clearFile = clearFile;
        vm.retrieveSubject = retrieveSubject;

        activate();

        function activate() {
            vm.course_id = $routeParams.course_id;
            if ($routeParams.id === undefined) {
                vm.content = new Content();
                vm.content.medium = {
                    is_attachment: 'true'
                }
                Content.query(function(data) {
                    vm.contents = data; 
                    Subject.query(function(data) {
                        vm.subjects = data;
                    });   
                });
            } else {
                vm.content = Content.get({id: $routeParams.id}, function() {
                    Subject.query(function(data) {
                        vm.subjects = data;
                        if (vm.content.category_type == "Subject") {
                            vm.content.subject_id = vm.content.category.id;
                        } else if (vm.content.category_type == "Field") {
                            vm.content.subject_id = vm.content.category.subject_id;
                            vm.content.field_id = vm.content.category.id;
                        }
                        retrieveSubject();
                        retrieveCourse();
                    });
                    if (!vm.content.medium.is_attachment) {
                        vm.content.medium.source = $sce.trustAsResourceUrl(vm.content.medium.reference);
                    } else vm.content.medium.source = vm.content.attachment_url;
                    vm.content.medium.is_attachment = vm.content.medium.is_attachment.toString();
                });
                PermissionsService.verifyPermissions(['permission.courses.teach', 'permission.courses.take_part'], function(permissions) {
                    vm.permissions = permissions;
                })
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

        function retrieveSubject() {
            vm.subject = Subject.get({id: vm.content.subject_id});
        }

        function retrieveCourse() {
            if ($routeParams.course_id) vm.course = Course.get({id: $routeParams.course_id});
        }

    }

})();