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
                'title': 'subjects.alerts.create.success.title',
                'content': 'subjects.alerts.create.success.content',
                'type': mTypes['success']
                },
            'subject.created.error': {
                'title': 'subjects.alerts.create.error.title',
                'content': 'subjects.alerts.create.error.content',
                'type': mTypes['error']
            },
            'subject.deleted.success': {
                'title': 'subjects.alerts.delete.success.title',
                'content': 'subjects.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'subject.deleted.error': {
                'title': 'subjects.alerts.delete.error.title',
                'content': 'subjects.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'subject.updated.success': {
                'title': 'subjects.alerts.update.success.title',
                'content': 'subjects.alerts.update.success.content',
                'type': mTypes['success']
            },
            'subject.updated.error': {
                'title': 'subjects.alerts.update.error.title',
                'content': 'subjects.alerts.update.error.content',
                'type': mTypes['error']
            },
            'question.created.success': {
                'title': 'questions.alerts.create.success.title',
                'content': 'questions.alerts.create.success.content',
                'type': mTypes['success']
            },
            'question.created.error': {
                'title': 'questions.alerts.create.error.title',
                'content': 'questions.alerts.create.error.content',
                'type': mTypes['error']
            },
            'question.deleted.success': {
                'title': 'questions.alerts.delete.success.title',
                'content': 'questions.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'question.deleted.error': {
                'title': 'questions.alerts.delete.error.title',
                'content': 'questions.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'question.updated.success': {
                'title': 'questions.alerts.update.success.title',
                'content': 'questions.alerts.update.success.content',
                'type': mTypes['success']
            },
            'question.updated.error': {
                'title': 'questions.alerts.update.error.title',
                'content': 'questions.alerts.update.error.content',
                'type': mTypes['success']
            },
            'role.created.success': {
                'title': 'roles.alerts.create.success.title',
                'content': 'roles.alerts.create.success.content',
                'type': mTypes['success']
            },
            'role.created.error': {
                'title': 'roles.alerts.create.error.title',
                'content': 'roles.alerts.create.error.content',
                'type': mTypes['error']
            },
            'role.deleted.success': {
                'title': 'roles.alerts.delete.success.title',
                'content': 'roles.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'role.deleted.error': {
                'title': 'roles.alerts.delete.error.title',
                'content': 'roles.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'role.updated.success': {
                'title': 'roles.alerts.update.success.title',
                'content': 'roles.alerts.update.success.content',
                'type': mTypes['success']
            },
            'role.updated.error': {
                'title': 'roles.alerts.update.error.title',
                'content': 'roles.alerts.update.error.content',
                'type': mTypes['error']
            },
            'user.created.success': {
                'title': 'users.alerts.create.success.title',
                'content': 'users.alerts.create.success.content',
                'type': mTypes['success']
            },
            'user.created.error': {
                'title': 'users.alerts.create.error.title',
                'content': 'users.alerts.create.error.content',
                'type': mTypes['error']
            },
            'user.deleted.success': {
                'title': 'users.alerts.delete.success.title',
                'content': 'users.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'user.deleted.error': {
                'title': 'users.alerts.delete.error.title',
                'content': 'users.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'user.updated.success': {
                'title': 'users.alerts.update.success.title',
                'content': 'users.alerts.update.success.content',
                'type': mTypes['success']
            },
            'user.updated.error': {
                'title': 'users.alerts.update.error.title',
                'content': 'users.alerts.update.error.content',
                'type': mTypes['error']
            },
            'user.changed_password.success' : {
                'title': 'users.alerts.change_password.success.title',
                'content': 'users.alerts.change_password.success.content',
                'type': mTypes['success']
            },
            'user.changed_password.error' : {
                'title': 'users.alerts.change_password.error.title',
                'content': 'users.alerts.change_password.error.content',
                'type': mTypes['error']
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
            'course.created.success': {
                'title': 'courses.alerts.create.success.title',
                'content': 'courses.alerts.create.success.content',
                'type': mTypes['success']
            },
            'course.created.error': {
                'title': 'courses.alerts.create.error.title',
                'content': 'courses.alerts.create.error.content',
                'type': mTypes['error']
            },
            'course.deleted.success': {
                'title': 'courses.alerts.delete.success.title',
                'content': 'courses.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'course.deleted.error': {
                'title': 'courses.alerts.delete.error.title',
                'content': 'courses.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'course.updated.success': {
                'title': 'courses.alerts.update.success.title',
                'content': 'courses.alerts.update.success.content',
                'type': mTypes['success']
            },
            'course.updated.error': {
                'title': 'courses.alerts.update.error.title',
                'content': 'courses.alerts.update.error.content',
                'type': mTypes['error']
            },
            'course.participants.added.success': {
                'title': 'courses.alerts.participants.add.success.title',
                'content': 'courses.alerts.participants.add.success.content',
                'type': mTypes['success']                
            },
            'course.participants.added.error': {
                'title': 'courses.alerts.participants.add.error.title',
                'content': 'courses.alerts.participants.add.error.content',
                'type': mTypes['error']                
            },
            'course.participants.removed.success': {
                'title': 'courses.alerts.participants.remove.success.title',
                'content': 'courses.alerts.participants.remove.success.content',
                'type': mTypes['success']                
            },
            'course.participants.removed.error': {
                'title': 'courses.alerts.participants.remove.error.title',
                'content': 'courses.alerts.participants.remove.error.content',
                'type': mTypes['error']
            },
            'field.created.success': {
                'title': 'fields.alerts.create.success.title',
                'content': 'fields.alerts.create.success.content',
                'type': mTypes['success']
            },
            'field.created.error': {
                'title': 'fields.alerts.create.error.title',
                'content': 'fields.alerts.create.error.content',
                'type': mTypes['error']
            },
            'field.updated.success': {
                'title': 'fields.alerts.update.success.title',
                'content': 'fields.alerts.update.success.content',
                'type': mTypes['success']
            },
            'field.updated.error': {
                'title': 'fields.alerts.update.error.title',
                'content': 'fields.alerts.update.error.content',
                'type': mTypes['error']
            },
            'field.deleted.success': {
                'title': 'fields.alerts.delete.success.title',
                'content': 'fields.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'field.deleted.error': {
                'title': 'fields.alerts.delete.error.title',
                'content': 'fields.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'content.created.success': {
                'title': 'contents.alerts.create.success.title',
                'content': 'contents.alerts.create.success.content',
                'type': mTypes['success']
            },
            'content.created.error': {
                'title': 'contents.alerts.create.error.title',
                'content': 'contents.alerts.create.error.content',
                'type': mTypes['error']
            },
            'content.deleted.success': {
                'title': 'contents.alerts.delete.success.title',
                'content': 'contents.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'content.deleted.error': {
                'title': 'contents.alerts.delete.error.title',
                'content': 'contents.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'content.updated.success': {
                'title': 'contents.alerts.update.success.title',
                'content': 'contents.alerts.update.success.content',
                'type': mTypes['success']
            },
            'content.updated.error': {
                'title': 'contents.alerts.update.error.title',
                'content': 'contents.alerts.update.error.content',
                'type': mTypes['error']
            },
            'request.created.success': {
                'title': 'requests.alerts.create.success.title',
                'content': 'requests.alerts.create.success.content',
                'type': mTypes['success']
            },
            'request.created.error': {
                'title': 'requests.alerts.create.error.title',
                'content': 'requests.alerts.create.error.content',
                'type': mTypes['error']
            },
            'request.deleted.success': {
                'title': 'requests.alerts.delete.success.title',
                'content': 'requests.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'request.deleted.error': {
                'title': 'requests.alerts.delete.error.title',
                'content': 'requests.alerts.delete.error.content',
                'type': mTypes['error']
            },
            'request.assessed.success': {
                'title': 'requests.alerts.assess.success.title',
                'content': 'requests.alerts.assess.success.content',
                'type': mTypes['success']
            },
            'request.assessed.error': {
                'title': 'requests.alerts.assess.error.title',
                'content': 'requests.alerts.assess.error.content',
                'type': mTypes['error']
            },
            'response.created.success': {
                'title': 'responses.alerts.create.success.title',
                'content': 'responses.alerts.create.success.content',
                'type': mTypes['success']
            },
            'response.created.error': {
                'title': 'responses.alerts.create.error.title',
                'content': 'response.alerts.create.error.content',
                'type': mTypes['error']
            },
            'response.deleted.success': {
                'title': 'responses.alerts.delete.success.title',
                'content': 'responses.alerts.delete.success.content',
                'type': mTypes['success']
            },
            'response.deleted.error': {
                'title': 'responses.alerts.delete.error.title',
                'content': 'responses.alerts.delete.error.content',
                'type': mTypes['error']
            } ,
            'response.updated.success': {
                'title': 'responses.alerts.update.success.title',
                'content': 'responses.alerts.update.success.content',
                'type': mTypes['success']
            },
            'response.updated.error': {
                'title': 'responses.alerts.update.error.title',
                'content': 'responses.alerts.update.error.content',
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
