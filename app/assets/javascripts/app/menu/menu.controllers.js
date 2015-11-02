(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('MenuController', MenuController);

    MenuController.$inject = ['$scope', 'Auth', 'RedirectService', 'PermissionsService'];

    function MenuController($scope, Auth, RedirectService, PermissionsService) {

        var vm = this;

        vm.logout = logout;
     
        activate();

        function activate() {
            PermissionsService.verifyPermissions([
                'permission.manipulate_roles',
                'permission.manipulate_users',
                'permission.manipulate_questions',
                'permission.manipulate_subjects',
                'permission.manipulate_contents',
                'permission.import_data'
            ], function(data) {
                vm.permissions = data;
            }, function(error) {

            });
        }

        function logout() {
            var config = {
                headers: { 'X-HTTP-Method-Override': 'DELETE' }
            };

            Auth.logout(config).then(function(oldUser) {
                window.location.href = "/";
            }, function(error) {
                
            });
        }

    }
    
})();