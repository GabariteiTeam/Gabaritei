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
            'question.created.success': {
                'title': 'crud.questions.alerts.create.success.title',
                'content': 'crud.questions.alerts.create.success.content',
                'type': mTypes['success']
            },
            'question.created.error': {
                'title': 'crud.questions.alerts.create.error.title',
                'content': 'crud.questions.alerts.create.error.content',
                'type': mTypes['error']
            },
            'question.deleted.success': {
                'title': 'crud.questions.alerts.delete.success.title',
                'content': 'crud.questions.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'question.deleted.error': {
                'title': 'crud.questions.alerts.delete.error.title',
                'content': 'crud.questions.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'question.updated.success': {
                'title': 'crud.questions.alerts.update.success.title',
                'content': 'crud.questions.alerts.update.success.content',
                'type': mTypes['success']
            },
            'question.updated.error': {
                'title': 'crud.questions.alerts.update.error.title',
                'content': 'crud.questions.alerts.update.error.content',
                'type': mTypes['success']
            },
            'data_import.uploaded.success': {
                'title': 'data_import.alerts.upload.success.title',
                'content': 'data_import.alerts.upload.success.content',
                'type': mTypes['success']
            },
            'data_import.uploaded.error': {
                'title': 'data_import.alerts.upload.error.title',
                'content': 'data_import.alerts.upload.error.content',
                'type': mTypes['error']
            },
            'data_import.updated.success': {
                'title': 'data_import.alerts.update.success.title',
                'content': 'data_import.alerts.update.success.content',
                'type': mTypes['success']
            },
            'data_import.updated.error': {
                'title': 'data_import.alerts.update.error.title',
                'content': 'data_import.alerts.update.error.content',
                'type': mTypes['error']
            },
            'data_import.deleted.success': {
                'title': 'data_import.alerts.delete.success.title',
                'content': 'data_import.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'data_import.deleted.error': {
                'title': 'data_import.alerts.delete.error.title',
                'content': 'data_import.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'field.created.success': {
                'title': 'crud.fields.alerts.create.success.title',
                'content': 'crud.fields.alerts.create.success.content',
                'type': mTypes['success']
            },
            'field.created.error': {
                'title': 'crud.fields.alerts.create.error.title',
                'content': 'crud.fields.alerts.create.error.content',
                'type': mTypes['error']
            },
            'field.updated.success': {
                'title': 'crud.fields.alerts.update.success.title',
                'content': 'crud.fields.alerts.update.success.content',
                'type': mTypes['success']
            },
            'field.updated.error': {
                'title': 'crud.fields.alerts.update.error.title',
                'content': 'crud.fields.alerts.update.error.content',
                'type': mTypes['error']
            },
            'field.deleted.success': {
                'title': 'crud.fields.alerts.delete.success.title',
                'content': 'crud.fields.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'field.deleted.error': {
                'title': 'crud.fields.alerts.delete.error.title',
                'content': 'crud.fields.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'user.created.success': {
                'title': 'crud.users.alerts.create.success.title',
                'content': 'crud.users.alerts.create.success.content',
                'type': mTypes['success']
            },
            'user.created.error': {
                'title': 'crud.users.alerts.create.error.title',
                'content': 'crud.users.alerts.create.error.content',
                'type': mTypes['error']
            },
            'user.updated.success': {
                'title': 'crud.users.alerts.update.success.title',
                'content': 'crud.users.alerts.update.success.content',
                'type': mTypes['success']
            },
            'user.updated.error': {
                'title': 'crud.users.alerts.update.error.title',
                'content': 'crud.users.alerts.update.error.content',
                'type': mTypes['error']
            },
            'user.deleted.success': {
                'title': 'crud.users.alerts.delete.success.title',
                'content': 'crud.users.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'user.deleted.error': {
                'title': 'crud.users.alerts.delete.error.title',
                'content': 'crud.users.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'role.created.success': {
                'title': 'crud.roles.alerts.create.success.title',
                'content': 'crud.roles.alerts.create.success.content',
                'type': mTypes['success']
            },
            'role.created.error': {
                'title': 'crud.roles.alerts.create.error.title',
                'content': 'crud.roles.alerts.create.error.content',
                'type': mTypes['error']
            },
            'role.updated.success': {
                'title': 'crud.roles.alerts.update.success.title',
                'content': 'crud.roles.alerts.update.success.content',
                'type': mTypes['success']
            },
            'role.updated.error': {
                'title': 'crud.roles.alerts.update.error.title',
                'content': 'crud.roles.alerts.update.error.content',
                'type': mTypes['error']
            },
            'role.deleted.success': {
                'title': 'crud.roles.alerts.delete.success.title',
                'content': 'crud.roles.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'role.deleted.error': {
                'title': 'crud.roles.alerts.delete.error.title',
                'content': 'crud.roles.alerts.delete.error.content',
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
