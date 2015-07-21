var homeControllers = angular.module('homeControllers', [])
homeControllers.controller('homeController', ['$scope',
    function($scope) {

    }
]);


var subjectControllers = angular.module('subjectControllers', [])
subjectControllers.controller('subjectController', ['$scope', '$location', '$routeParams', 'Subject', 'MessageService',
    function($scope, $location, $routeParams, Subject, MessageService) {
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

        if ($routeParams.status && $routeParams.action) {
            $scope.message = MessageService.get($routeParams.status, "Subject", $routeParams.action);
        } 

        $scope.createSubject = function() {
            $scope.subject.$save(function() {
                   $location.path("/subjects/success/ok/created");
                },
                function(err) {
                    $location.path("/subjects/success/error/created");
                });
        };

        $scope.updateSubject = function() {
            $scope.subject.$update(function() {
            		$scope.redirect("/subjects/success/ok/updated");
                    
                },
                function(err) {
                    $scope.redirect("/subjects/success/error/updated");
                });
        }

        $scope.deleteSubject = function(id) {
        	
            Subject.destroy({id: id}, function() {
            		$scope.redirect("/subjects/success/ok/deleted");
                },
                function(err) {
                    $scope.redirect("/subjects/success/error/deleted");
                });
        }

        $scope.redirect = function(newUrl) {
        	if($location.path() == newUrl)
        		$location.reload();
        	else
        		$location.path(newUrl);
        }
    }
]);