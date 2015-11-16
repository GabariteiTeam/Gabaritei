(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('MenuController', MenuController);

    MenuController.$inject = ['$scope', 'Auth', 'RedirectService'];

    function MenuController($scope, Auth, RedirectService) {

        var vm = this;

        vm.logout = logout;
        vm.changeMenuDisplay = changeMenuDisplay;
        vm.collapseMenu = false;
     
        function logout() {
            var config = {
                headers: { 'X-HTTP-Method-Override': 'DELETE' }
            };

            Auth.logout(config).then(function(oldUser) {
                window.location.href = "/";
            }, function(error) {
                
            });
        }

        function changeMenuDisplay() {
            jQuery("#wrapper").toggleClass("toggled", vm.collapseMenu);
            if (vm.collapseMenu) {
                jQuery("[data-toggle='menu-tooltip']").tooltip();
            } else {
                jQuery("[data-toggle='menu-tooltip']").tooltip('destroy');
            }
        }

    }
    
})();