(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('SubjectsController', SubjectsController);

    SubjectsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Subject',
            'MessageService',
            'RedirectService',
            'ModalService',
            'Modal'
        ];

    function SubjectsController($location, $routeParams, $route, Subject, MessageService, RedirectService, ModalService, Modal) {
        var vm = this;
        vm.createSubject = createSubject;
        vm.updateSubject = updateSubject;
        vm.deleteSubject = deleteSubject;
        vm.c_delete      = c_delete;

        vm.subjects = [];

        if (!($routeParams.id === undefined)) {
            vm.subject = Subject.get({
                id: $routeParams.id
            });

        } else {
            vm.subject = new Subject();
            Subject.query(function(data) {
                vm.subjects = data;
            });
        }
        

        function createSubject() {
            vm.subject.$save(function() {
                    MessageService.sendMessage('subject.created.success');
                    RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT created with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        };

        function updateSubject() {
            vm.subject.$update(function() {
                    MessageService.sendMessage("Updated!", "Subject was updated with success!", "success");
                    RedirectService.redirect("/subjects");

                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT updated with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        }

        function deleteSubject(id) {

            Subject.validateDestroy({id: id}, function(data) {
                if(data.model_bind) {
                    ModalService.customModal('subjects.confirm_delete_questions', c_delete, id);
                } else {
                    ModalService.customModal('subjects.confirm_delete', c_delete, id);
                }
            });
        }

        function c_delete(id) {
            Subject.destroy({
                    id: id
                }, function() {
                    MessageService.sendMessage("Deleted!", "Subject was deleted with success!", "success");
                    RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT deleted with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        }
    };

})();
