(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('TestsController', TestsController);

    TestsController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Test',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function TestsController($location, $routeParams, $route, Test, MessageService, RedirectService, ModalService) {
        var vm = this;
        vm.createTest    = createTest;
        vm.updateTest    = updateTest;
        vm.c_delete         = c_delete;
        vm.delete_modal_id  = "confirmDeleteTest";

        vm.tests = [];

        if (!($routeParams.id === undefined)) {
            vm.test = Test.get({
                id: $routeParams.id
            });

        } else {
            vm.test = new Test();
            Test.query(function(data) {
                vm.tests = data;
            });
        }
        


        function createTest() {
            vm.test.$save(function() {
                    MessageService.sendMessage('test.created.success');
                    RedirectService.redirect("/tests");
                },
                function(err) {
                    MessageService.sendMessage('test.created.error');
                    RedirectService.redirect("/tests");
                });
        };

        function updateTest() {
            vm.test.$update(function() {
                    MessageService.sendMessage('test.updated.success');
                    RedirectService.redirect("/tests");

                },
                function(err) {
                    MessageService.sendMessage('test.updated.error');
                    RedirectService.redirect("/tests");
                });
        }


        function c_delete(id) {
            Test.destroy({
                    id: id
                }, function() {
                    MessageService.sendMessage('test.deleted.success');
                    RedirectService.redirect("/tests");
                },
                function(err) {
                    MessageService.sendMessage('test.deleted.error');
                    RedirectService.redirect("/tests");
                });
        }
    };

})();
