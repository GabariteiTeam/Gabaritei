(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .factory('MessageService', MessageService)
        .factory('RedirectService', RedirectService)

    MessageService.$inject = ['Message'];

    function MessageService(Message) {
        var mTypes = {
            "success": "success",
            "error": "danger"   
        }

        var message;

        var observers = [];

        function addObserver(functionCallback) {
            observers.push(functionCallback);
        }

        function alertObservers() {
            angular.forEach(observers, function(callback){
                callback(message);
            });
        }

        function sendMessage(nTitle, nMessage, nType) {
            message = new Message();
            message.title = nTitle;
            message.content = nMessage;
            message.type = mTypes[nType];
            alertObservers();
        }

        function getMessage() {
            return message;
        }

        return {
            addObserver: addObserver,
            sendMessage: sendMessage,
            getMessage: getMessage
        }
    }

    RedirectService.$inject = ['$route', '$location'];

    function RedirectService($route, $location) {
        function redirect(newUrl) {
            if($location.path() == newUrl)
                $route.reload();
            else
                $location.path(newUrl);
        }
        return {
            redirect: redirect
        }
    }

})();


// app.factory('MessageService',['Message', function(Message) {
//     var mTypes = {
//     	"success": "success",
//     	"error": "danger"	
//     }

//     var message;

//     var observers = [];

//     function addObserver(functionCallback) {
//         observers.push(functionCallback);
//     }

//     function alertObservers() {
//         angular.forEach(observers, function(callback){
//             callback(message);
//         });
//     }

//     function sendMessage(nTitle, nMessage, nType) {
//         message = new Message();
//         message.title = nTitle;
//         message.content = nMessage;
//         message.type = mTypes[nType];
//         alertObservers();
//     }

//     function getMessage() {
//         return message;
//     }

//     return {
//         addObserver: addObserver,
//         sendMessage: sendMessage,
//         getMessage: getMessage
//     }

// }]);

// app.factory('RedirectService',['$route', '$location', function($route, $location) {
//     function redirect(newUrl) {
//             if($location.path() == newUrl)
//                 $route.reload();
//             else
//                 $location.path(newUrl);
//     }

//     return {
//         redirect: redirect
//     }

// }]);