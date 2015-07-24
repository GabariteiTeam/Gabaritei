var homeControllers = angular.module('homeControllers', [])
homeControllers.controller('homeController', ['$scope','MessageService',
    function($scope, MessageService) {
      
    }
]);

app.controller('messageController', ['$scope', '$interval', '$alert','Message', 'MessageService', function($scope, $interval, $alert, Message, MessageService) {
    $scope.message = new Message();

    $scope.receiveMessage = function(message) {
        $scope.message = message;
        $scope.alert = $alert({container: "#messageContainer", duration: 5, title: $scope.message.title, content: $scope.message.content, placement: 'top', type: $scope.message.type, show: true});
    }

    MessageService.addObserver($scope.receiveMessage);
}]);

var subjectControllers = angular.module('subjectControllers', [])
subjectControllers.controller('subjectController', ['$scope', '$location', '$routeParams', '$route', 'Subject', 'MessageService', 'RedirectService',
    function($scope, $location, $routeParams, $route, Subject, MessageService, RedirectService) {
        $scope.subjects = [];
        $scope.subject = new Subject();

        if (!($routeParams.id === undefined)) {
            $scope.subject = Subject.get({
                id: $routeParams.id
            });

        } else {
            Subject.query(function(data) {
                $scope.subjects = data;
            });
        } 

        $scope.createSubject = function() {
            $scope.subject.$save(function() {
                    MessageService.sendMessage("Created!", "Subject was created with success!", "success");
                    RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT created with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        };

        $scope.updateSubject = function() {
            $scope.subject.$update(function() {
                    MessageService.sendMessage("Updated!", "Subject was updated with success!", "success");
            		RedirectService.redirect("/subjects");
                    
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT updated with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        }

        $scope.deleteSubject = function(id) {
        	
            Subject.destroy({id: id}, function() {
                    MessageService.sendMessage("Deleted!", "Subject was deleted with success!", "success");
            		RedirectService.redirect("/subjects");
                },
                function(err) {
                    MessageService.sendMessage("Fail!", "Subject was NOT deleted with success!", "error");
                    RedirectService.redirect("/subjects");
                });
        }
    }
]);