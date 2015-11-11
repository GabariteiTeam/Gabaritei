(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('AuthenticationController', AuthenticationController);

    AuthenticationController
        .$inject = [
            '$scope',
            '$location',
            '$routeParams',
            '$route',
            'Auth'
        ];

    function AuthenticationController($scope, $location, $routeParams, $route, Auth) {
        
        var vm = this;

        vm.login = login;
        vm.clearStatus = clearStatus;

        vm.credentials = {
            email: "",
            password: ""
        };

        vm.fields_status = {
            email: '',
            password: ''
        }

        var config = {
            headers: {
                'X-HTTP-Method-Override': 'POST'
            },
            interceptAuth: false
        };

        activate();

        function activate() {
            jQuery("#login-email").popover({
                trigger: 'manual',
                placement: 'top',
                content: function() {
                    if (vm.fields_status.email == 'warning') return "Provide your e-mail";
                    else if (vm.fields_status.email == 'error') return "E-mail and/or password incorrect!"
                }
            });
            jQuery("#login-password").popover({
                trigger: 'manual',
                placement: 'bottom',
                content: "Provide your password"
            });
        }

        function login() {
            if (vm.credentials.email.length > 0) {
                if (vm.credentials.password.length > 0) {
                    Auth.login(vm.credentials, config).then(function(user) {

                    }, function(error) {
                        vm.fields_status.email = 'error';
                        vm.fields_status.password = 'error';
                        jQuery("#login-email").popover('show');
                    });
                } else {
                    vm.fields_status.password = 'warning';
                    jQuery("#login-password").popover('show');
                }
            } else {
                vm.fields_status.email = 'warning'
                jQuery("#login-email").popover('show');
            }
        }

        function clearStatus() {
            vm.fields_status.email = "";
            vm.fields_status.password = "";
            jQuery("#login-email").popover('hide');
            jQuery("#login-password").popover('hide');
        }

        $scope.$on('devise:login', function(event, currentUser) {
            window.location.href = "/";
        });

    }

})();