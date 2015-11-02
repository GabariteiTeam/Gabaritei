(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('UsersController', UsersController)
        .controller('EditUserController', EditUserController);

    UsersController.$inject = ['$routeParams', 'usersPrepService', 'User', 'MessageService', 'ModalService'];
    
    function UsersController($routeParams, usersPrepService, User, MessageService, ModalService) {
        
        var vm = this;

        vm.c_delete = c_delete;
        vm.user = usersPrepService;
        vm.users = usersPrepService; 

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

    EditUserController.$inject = ['$routeParams', 'rolesPrepService', 'usersPrepService', 'User', 'MessageService', 'RedirectService'];

    function EditUserController($routeParams, rolesPrepService, usersPrepService, User, MessageService, RedirectService) {

        var vm = this;

        vm.createUser = createUser;
        vm.updateUser = updateUser;
        vm.clearAvatar = clearAvatar;

        vm.roles = rolesPrepService;
        vm.user = usersPrepService;

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
