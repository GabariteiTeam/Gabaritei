(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('UsersController', UsersController)
        .controller('EditUserController', EditUserController);

    UsersController.$inject = ['$routeParams', 'Auth', 'User', 'MessageService', 'RedirectService', 'ModalService'];
    
    function UsersController($routeParams, Auth, User, MessageService, RedirectService, ModalService) {
        
        var vm = this;

        vm.c_delete = c_delete;
        vm.changePassword = changePassword;

        activate();

        function activate() {
            if ($routeParams.id) {
                vm.user = User.get({id: $routeParams.id}, function(user) {
                    if (user.about == "null") user.about = "";
                    Auth.currentUser().then(function(current_user) {
                        vm.user_self = (user.id == current_user.id);
                    }, function(error) {
                        vm.user_self = false;
                    });
                });
            } else {
                vm.users = User.query();
            }
        }

        function changePassword() {
            vm.user.$changePassword(function(success) {
                MessageService.sendMessage('user.changed_password.success');
                RedirectService.redirect("/users/" + $routeParams.id);
            }, function(error) {
                MessageService.sendMessage('user.changed_password.error');
            })
        }

        function c_delete(id) {
            User.delete({id: id}, function() {
                MessageService.sendMessage('user.deleted.success');
                vm.reload = true;
            },
            function(err) {
                MessageService.sendMessage('user.deleted.error');
                vm.reload = true;
            });
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
            if ($routeParams.id) {
                vm.user = User.get({id: $routeParams.id}, function(user) {
                    user.birthdate = user.birthdate ? new Date(user.birthdate) : null;
                    if (user.about = "null") user.about = "";
                    if (!user.has_avatar) user.avatar = null;
                });
            } else {
                vm.user = new User();
            }
            vm.roles = Role.query();
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
            jQuery('#avatar').wrap('<form>').closest('form').get(0).reset();
            jQuery('#avatar').unwrap();
        }

    }

})();
