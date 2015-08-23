(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .factory('RedirectService', RedirectService);

    RedirectService.$inject = ['$route', '$location'];

    function RedirectService($route, $location) {
        function redirect(newUrl) {
            if ($location.path() == newUrl)
                $route.reload();
            else
                $location.path(newUrl);
        }
        return {
            redirect: redirect
        }
    }

})();
