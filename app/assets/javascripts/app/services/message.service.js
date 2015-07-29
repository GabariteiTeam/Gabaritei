(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .factory('MessageService', MessageService);

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

})();