(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .config(Authentication)
        .run(UnauthorizedAccessEvent);

    function Authentication(AuthInterceptProvider) {
        AuthInterceptProvider.interceptAuth(true);
    }

    function UnauthorizedAccessEvent($rootScope, RedirectService) {

    	$rootScope.$on('devise:unauthorized', function(event, xhr, deferred) {
            RedirectService.redirect("/users/login");
        });
        
    }

})();