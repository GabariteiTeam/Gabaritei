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
            'subject.created.error': {
                'title': 'crud.subjects.alerts.create.error.title',
                'content': 'crud.subjects.alerts.create.error.content',
                'type': mTypes['error']
            },
            'subject.deleted.success': {
                'title': 'crud.subjects.alerts.delete.success.title',
                'content': 'crud.subjects.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'subject.deleted.error': {
                'title': 'crud.subjects.alerts.delete.error.title',
                'content': 'crud.subjects.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'subject.updated.success': {
                'title': 'crud.subjects.alerts.update.success.title',
                'content': 'crud.subjects.alerts.update.success.content',
                'type': mTypes['success']
            },
            'subject.updated.error': {
                'title': 'crud.subjects.alerts.update.error.title',
                'content': 'crud.subjects.alerts.update.error.content',
                'type': mTypes['error']
            },
            'question.created.sucess': {
                'title': 'crud.questions.alerts.create.success.title',
                'content': 'crud.questions.alerts.create.success.content',
                'type': mTypes['success']
            },
            'question.created.error': {
                'title': 'crud.questions.alerts.create.error.title',
                'content': 'crud.questions.alerts.create.error.content',
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
