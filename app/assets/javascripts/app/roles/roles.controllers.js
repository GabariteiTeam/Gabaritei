(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('RolesController', RolesController);

    RolesController.$inject = ['$location', '$routeParams', '$route', '$filter', 'Role', 'Permission', 'MessageService', 'RedirectService', 'ModalService'];

    function RolesController($location, $routeParams, $route, $filter, Role, Permission, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.createRole = createRole;
        vm.updateRole = updateRole;
        vm.c_delete = c_delete;
        vm.showHelpPopover = showHelpPopover;

        vm.roles = [];
        vm.permissions = {
            "contents": [],
            "courses": [],
            "users": [],
            "roles": [],
            "questions": [],
            "subjects_fields": [],
            "requests": [],
            "import_data": []
        };

        activate();

        function activate() {
            if (!($routeParams.id === undefined)) {
                vm.role = Role.get({
                    id: $routeParams.id
                }, function() {
                    Permission.query(function(data) {
                        for (var i = 0; i < data.length; i++) {
                            var p = data[i];
                            p.allowed = vm.role.permissions.some(function(element) {
                                return element.id == p.id
                            });
                            vm.permissions[data[i].tag].push(p);
                        }
                    }); 
                });
            } else {
                vm.role = new Role();
                Role.query(function(data) {
                    vm.roles = data;
                    Permission.query(function(data) {
                        for (var i = 0; i < data.length; i++) {
                            var p = data[i];
                            p.allowed = false;
                            vm.permissions[data[i].tag].push(p);
                        }
                    });
                });
            }       
        }
        
        function createRole() {
            vm.role.permissions = [];
            for (var property in vm.permissions) {
                for (var i = 0; i < vm.permissions[property].length; i++) {
                    if (vm.permissions[property][i].allowed) vm.role.permissions.push(vm.permissions[property][i].id);
                }
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
            for (var property in vm.permissions) {
                for (var i = 0; i < vm.permissions[property].length; i++) {
                    if (vm.permissions[property][i].allowed) vm.role.permissions.push(vm.permissions[property][i].id);
                }
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

        function c_delete(id) {
            Role.delete({id: id}, function() {
                MessageService.sendMessage('role.deleted.success');
                RedirectService.redirect("/roles");
            },
            function(err) {
                MessageService.sendMessage('role.deleted.error');
                RedirectService.redirect("/roles");
            });
        }

        function showHelpPopover(permission_id, permission_name) {
            var btn = jQuery("#permission_" + permission_id);
            if (btn.attr("popover-active") == "false") {
                btn.attr("popover-active", "true");
                btn.popover({
                    placement: 'top',
                    title: $filter('translate')(permission_name + '.title'),
                    content: $filter('translate')(permission_name + '.help'),
                    trigger: 'focus'
                });
                btn.popover('show');
            }
        }

    };

})();
