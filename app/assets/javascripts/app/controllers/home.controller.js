(function() {

	'use strict';

	angular
        .module(APP_NAME)
        .controller('HomeController', HomeController);

    HomeController.$inject = ['MessageService'];

    function HomeController(MessageService) {
    
    };

})();