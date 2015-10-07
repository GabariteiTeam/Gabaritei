(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('UsersController', UsersController)
        .controller('EditUserController', EditUserController);

    UsersController
        .$inject = [
            '$routeParams',
            'User',
            'Role',
            'MessageService',
            'RedirectService',
            'ModalService'
        ];

    function UsersController($routeParams, User, Role, MessageService, RedirectService, ModalService) {
        
        var vm = this;
        vm.c_delete = c_delete;
        vm.delete_modal_id  = "confirmDeleteUser";
        vm.users = [];
    
        activate();

        function activate() {
            if (!($routeParams.id === undefined)) {
                vm.user = User.get({id: $routeParams.id});
            } else {
                User.query(function(data) {
                    vm.users = data;
                });                
            }           
        }

        function c_delete(id) {
            User.delete({id: id}, function() {
                MessageService.sendMessage('user.deleted.success');
                reloadPage();
            },
            function(err) {
                MessageService.sendMessage('user.deleted.success');
                reloadPage();
            });
        }

        function reloadPage() {
            vm.reload = true;
        }

    };

    EditUserController.$inject = ['$routeParams', 'User', 'Role', 'MessageService', 'RedirectService'];

    function EditUserController($routeParams, User, Role, MessageService, RedirectService) {

        var vm = this;
        vm.createUser = createUser;
        vm.updateUser = updateUser;
        vm.clearAvatar = clearAvatar;


        activate();

        function activate() {
            Role.query(function(data) {
                vm.roles = data;
                if (!($routeParams.id === undefined)) {
                    vm.user = User.get({
                        id: $routeParams.id
                    }, function() {
                        vm.user.birthdate = new Date(vm.user.birthdate);
                        if (!vm.user.has_avatar) vm.user.avatar = null;
                        vm.formerAvatar = vm.user.avatar;
                    });
                } else {
                    vm.user = new User();
                    vm.user.role_id = vm.roles[0].id
                }
            });          
        }      

        function createUser() {
            vm.user.$save(function() {
                MessageService.sendMessage('user.created.success');
                RedirectService.redirect("/users");
            },
            function(err) {
                MessageService.sendMessage('user.created.error');
                RedirectService.redirect("/users");
            });
        }

        function updateUser() {
            if (vm.formerAvatar == vm.user.avatar) vm.user.avatar = "";
            vm.user.$update(function() {
                MessageService.sendMessage('user.updated.success');
                RedirectService.redirect("/users");
            },
            function(err) {
                MessageService.sendMessage('user.updated.error');
                RedirectService.redirect("/users");
            });
        }

        function clearAvatar() {
            vm.user.avatar = null;
            $('#avatar').wrap('<form>').closest('form').get(0).reset();
            $('#avatar').unwrap();
        }

    }

})();
