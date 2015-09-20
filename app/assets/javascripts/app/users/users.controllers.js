(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('UsersController', UsersController)
        .controller('EditUserController', EditUserController);

    UsersController.$inject = ['$routeParams', 'User', 'Role', 'MessageService', 'RedirectService', 'ModalService', 'Modal'];

    function UsersController($routeParams, User, Role, MessageService, RedirectService, ModalService, Modal) {
        
        var vm = this;
        vm.deleteUser = deleteUser;
        vm.c_delete = c_delete;
    
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

        function deleteUser(user_id) {
            var modal = new Modal();
            modal.title = "Confirmation";
            modal.body = "Are you sure you want to delete this user? All objects owned by them will also be destroyed.";
            modal.confirmCallback = c_delete;
            modal.pack = user_id;
            ModalService.alert(modal);
        }

        function c_delete(id) {
            User.delete({id: id}, function() {
                MessageService.sendMessage("Deleted!", "Role was deleted with success!", "success");
                reloadPage();
            },
            function(err) {
                MessageService.sendMessage("Fail!", "Role was NOT deleted with success!", "error");
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
                MessageService.sendMessage("Created!", "User was created with success!", "success");
                RedirectService.redirect("/users");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "User was NOT created with success!", "error");
                RedirectService.redirect("/users");
            });
        }

        function updateUser() {
            if (vm.formerAvatar == vm.user.avatar) vm.user.avatar = "";
            vm.user.$update(function() {
                MessageService.sendMessage("Updated!", "User was updated with success!", "success");
                RedirectService.redirect("/users");
            },
            function(err) {
                MessageService.sendMessage("Fail!", "User was NOT updated with success!", "error");
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
