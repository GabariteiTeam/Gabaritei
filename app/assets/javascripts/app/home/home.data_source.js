(function() {
    
    "use strict";
    
    angular
        .module(APP_NAME)
        .factory('HomeDataSource', HomeDataSource);

    HomeDataSource.$inject = ['$http'];

    function HomeDataSource($http) {
        return {
            getHomeInfo: getHomeInfo
        };

        function getHomeInfo() {
            return $http.get('home').then(function(data) {
                return data.data;
            }, function(error) {
                return error.data;
            });
        }
    }

})();