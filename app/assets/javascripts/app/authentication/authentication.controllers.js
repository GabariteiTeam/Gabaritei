(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .controller('AuthenticationController', AuthenticationController)
        .controller('ForgotPasswordController', ForgotPasswordController);

    AuthenticationController.$inject = ['$scope', '$location', '$routeParams', '$route', '$filter', 'Auth'];

    function AuthenticationController($scope, $location, $routeParams, $route, $filter, Auth) {
        
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
                    if (vm.fields_status.email == 'warning') return $filter('translate')('authentication.email_missing');
                    else if (vm.fields_status.email == 'error') return $filter('translate')('authentication.incorrect_credentials');
                }
            });
            jQuery("#login-password").popover({
                trigger: 'manual',
                placement: 'bottom',
                content: $filter('translate')('authentication.password_missing')
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


    ForgotPasswordController.$inject = ['$scope', '$location', '$routeParams', '$route', '$filter', 'User', 'RedirectService', 'MessageService'];

    function ForgotPasswordController($scope, $location, $routeParams, $route, $filter, User, RedirectService, MessageService) {

        var vm = this;

        vm.resetPassword = resetPassword;
        vm.clearStatus = clearStatus;

        activate();

        function activate() {
            jQuery("#forgot-password-email").popover({
                trigger: 'manual',
                placement: 'bottom',
                content: function() {
                    return $filter('translate')('authentication.forgot_password.invalid_email');
                }
            });
        }

        function resetPassword() {
            if (vm.email) {
                User.reset_password({email: vm.email}, function(success) {
                    RedirectService.redirect("/password_sent");
                }, function(error) {
                    if (error.status == 422) {
                        vm.email_status = 'error';
                        jQuery("#forgot-password-email").popover('show');
                    } else {
                        MessageService.sendMessage('user.forgot_password.error');
                    }
                });
            }
        }

        function clearStatus() {
            if (vm.email_status != "") {
                vm.email_status = "";
                jQuery("#forgot-password-email").popover('hide');
            }
        }

    }


})();