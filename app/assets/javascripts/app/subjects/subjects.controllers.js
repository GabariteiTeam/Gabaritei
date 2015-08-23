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
            'RedirectService'
        ];

    function SubjectsController($location, $routeParams, $route, Subject, MessageService, RedirectService) {
        var vm = this;
        vm.createSubject = createSubject;
        vm.updateSubject = updateSubject;
        vm.deleteSubject = deleteSubject;

        vm.subjects = [];
        vm.subjects = new Subject();

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
                    MessageService.sendMessage("Created!", "Subject was created with success!", "success");
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
