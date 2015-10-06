(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('RolesController', RolesController);

    RolesController
        .$inject = [
            '$location',
            '$routeParams',
            '$route',
            'Role',
            'Permission',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function RolesController($location, $routeParams, $route, Role, Permission, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.createRole = createRole;
        vm.updateRole = updateRole;
        vm.deleteRole = deleteRole;
        vm.c_delete = c_delete;
        vm.delete_modal_id  = "confirmDeleteRole";

        vm.roles = [];
        vm.permissions = [];
        
        if (!($routeParams.id === undefined)) {
            vm.role = Role.get({
                id: $routeParams.id
            }, function() {
                Permission.query(function(data) {
                    vm.permissions = data;
                    for (var i = 0; i < vm.permissions.length; i++) {
                        vm.permissions[i].allowed = vm.role.permissions.some(function(element) {
                            return element.id == vm.permissions[i].id
                        });
                    }
                }); 
            });
        } else {
            vm.role = new Role();
            Role.query(function(data) {
                vm.roles = data;
                Permission.query(function(data) {
                    vm.permissions = data;
                    for (var i = 0; i < vm.permissions.length; i++) vm.permissions[i].allowed = false;
                });
            });
        }

        function createRole() {
            vm.role.permissions = [];
            for (var i = 0; i < vm.permissions.length; i++) {
                if (vm.permissions[i].allowed) vm.role.permissions.push(vm.permissions[i].id);
            }
            vm.role.$save(function() {
                MessageService.sendMessage('role.created.success');
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage('role.created.error');
                RedirectService.redirect("/roles");
            });
        };

        function updateRole() {
            vm.role.permissions = [];
            for (var i = 0; i < vm.permissions.length; i++) {
                if (vm.permissions[i].allowed) vm.role.permissions.push(vm.permissions[i].id);
            }
            if (vm.role.permissions.length == 0) vm.role.permissions = undefined;
            vm.role.$update(function() {
                MessageService.sendMessage('role.updated.success');
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage('role.updated.error');
                RedirectService.redirect("/roles");
            });
        }

        function deleteRole(id) {
            ModalService.registerCallback(c_delete);
            ModalService.setArgs(id);
            $("#" + vm.delete_modal_id).modal();
        }

        function c_delete(id) {
            ModalService.hideModal();
            Role.delete({
                id: id
            }, function() {
                MessageService.sendMessage('role.deleted.success');
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage('role.deleted.error');
                RedirectService.redirect("/roles");
            });
        }
    };

})();
