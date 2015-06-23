

var homeControllers = angular.module('homeControllers', [])
homeControllers.controller('homeController', ['$scope', function($scope){
	
}]);


var subjectControllers = angular.module('subjectControllers', [])
subjectControllers.controller('subjectController', ['$scope', 'Subject', function($scope, Subject){
  $scope.subjects = [];
  Subject.query(function (data){
    $scope.subjects = data;
  });
}])