// We will insert here all Javascript related to Angular
// Simply and central


var app = angular.module("gabariteiApp",['ngResource', 'ngRoute']);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/home', {
        templateUrl: 'assets/partials/home/home.html',
        controller: 'HomeController'
      }).
      otherwise({
        redirectTo: '/home'
      });
  }]);


app.controller('HomeController', ['$scope', function($scope){
	
}])