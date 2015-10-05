(function() {

    'use strict';

    angular
        .module(APP_NAME)
        .factory('MessageService', MessageService);

    MessageService.$inject = ['Message', '$translate'];

    function MessageService(Message, $translate) {
        var mTypes = {
            'success': 'success',
            'error': 'danger'
        };
        var messageList = { 
            'subject.created.success': {
                'title': 'crud.subjects.alerts.create.success.title',
                'content': 'crud.subjects.alerts.create.success.content',
                'type': mTypes['success']
                },
            'data_import.upload.success': {
                'title': 'data_import.alerts.upload.success.title',
                'content': 'data_import.alerts.upload.success.content',
                'type': mTypes['success']
            },
            'data_import.upload.error': {
                'title': 'data_import.alerts.upload.error.title',
                'content': 'data_import.alerts.upload.error.content',
                'type': mTypes['error']
            },
            'data_import.update.success': {
                'title': 'data_import.alerts.update.success.title',
                'content': 'data_import.alerts.update.success.content',
                'type': mTypes['success']
            },
            'data_import.update.error': {
                'title': 'data_import.alerts.update.error.title',
                'content': 'data_import.alerts.update.error.content',
                'type': mTypes['error']
            },
            'data_import.delete.success': {
                'title': 'data_import.alerts.delete.success.title',
                'content': 'data_import.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'data_import.delete.error': {
                'title': 'data_import.alerts.delete.error.title',
                'content': 'data_import.alerts.delete.error.content',
                'type': mTypes['error']
            }
        };
        var observers = [];
        var message;
        
        function addObserver(functionCallback) {
            observers.push(functionCallback);
        }

        function alertObservers() {
            angular.forEach(observers, function(callback) {
                callback(message);
            });
        }

        function sendMessage(messageId) {
            $translate([messageList[messageId]['title'], messageList[messageId]['content']])
                      .then(function(translations){
                        message         = new Message();
                        message.title   = translations[messageList[messageId].title];
                        message.content = translations[messageList[messageId].content];
                        message.type    = messageList[messageId].type;
                        alertObservers();
                      });
        }

        function getMessage() {
            return message;
        }

        return {
            addObserver: addObserver,
            sendMessage: sendMessage,
            getMessage:  getMessage
        }
    }

})();
