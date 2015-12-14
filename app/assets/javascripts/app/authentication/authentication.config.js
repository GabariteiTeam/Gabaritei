(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(Authentication)
        .run(UnauthorizedAccessEvent);

    Authentication.$inject = ['AuthInterceptProvider'];

    function Authentication(AuthInterceptProvider) {
        AuthInterceptProvider.interceptAuth(true);
    }

    UnauthorizedAccessEvent.$inject = ['$rootScope', 'Auth', 'RedirectService'];

    function UnauthorizedAccessEvent($rootScope, Auth, RedirectService) {

    	$rootScope.$on('devise:unauthorized', function(event, xhr, deferred) {
            if (Auth.isAuthenticated()) RedirectService.redirect("/home");
            else RedirectService.redirect("/users/login");
        });
        
    }

})();