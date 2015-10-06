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
            'ModalService'
        ];

    function SubjectsController($location, $routeParams, $route, Subject, MessageService, RedirectService, ModalService) {
        var vm = this;
        vm.createSubject    = createSubject;
        vm.updateSubject    = updateSubject;
        vm.c_delete         = c_delete;
        vm.delete_modal_id  = "confirmDeleteSubject";

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
                    MessageService.sendMessage('subject.created.error');
                    RedirectService.redirect("/subjects");
                });
        };

        function updateSubject() {
            vm.subject.$update(function() {
                    MessageService.sendMessage('subject.updated.success');
                    RedirectService.redirect("/subjects");

                },
                function(err) {
                    MessageService.sendMessage('subject.updated.error');
                    RedirectService.redirect("/subjects");
                });
        }


        function c_delete(id) {
            Subject.destroy({
                    id: id
                }, function() {
                    MessageService.sendMessage('subject.deleted.success');
                    RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage('subject.deleted.error');
                    RedirectService.redirect("/subjects");
                });
        }
    };

})();
