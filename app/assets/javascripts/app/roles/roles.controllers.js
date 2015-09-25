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
            'ModalService',
            'Modal'
        ];

    function RolesController($location, $routeParams, $route, Role, Permission, MessageService, RedirectService, ModalService, Modal) {
        
        var vm = this;

        vm.createRole = createRole;
        vm.updateRole = updateRole;
        vm.deleteRole = deleteRole;
        vm.c_delete = c_delete;

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
                MessageService.sendMessage("Created!", "Role was created with success!", "success");
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Role was NOT created with success!", "error");
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
                MessageService.sendMessage("Updated!", "Role was updated with success!", "success");
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Role was NOT updated with success!", "error");
                RedirectService.redirect("/roles");
            });
        }

        function deleteRole(role_id) {
            Role.validateDestroy({id: role_id}, function(data) {
                if(data.count) {
                    var modal = new Modal();
                    modal.title = 'Confirmation';
                    modal.body = "Deleting this role will delete all users associated with it. Want to continue?\n"
                                  + "Users related: " + data.count;
                    modal.pack = role_id;
                    modal.confirmCallback = c_delete;
                    ModalService.alert(modal);
                } else {
                    var modal = new Modal();
                    modal.title = "Confirmation";
                    modal.body = "Are you sure you want to delete?";
                    modal.confirmCallback = c_delete;
                    modal.pack = role_id;
                    ModalService.alert(modal);
                }
            });
        }

        function c_delete(id) {
            Role.delete({
                id: id
            }, function() {
                MessageService.sendMessage("Deleted!", "Role was deleted with success!", "success");
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Role was NOT deleted with success!", "error");
                RedirectService.redirect("/roles");
            });
        }
    };

})();
