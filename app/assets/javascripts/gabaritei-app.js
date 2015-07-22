// We will insert here all Javascript related to Angular
// Simply and central

// Proposed styleguide: https://github.com/johnpapa/angular-styleguide

var APP_NAME = 'gabariteiApp';

(function() {

    'use strict';

	angular
		.module(APP_NAME, [
			'ngResource',
			'ngRoute',
			'ngFileUpload'
		]);

})();


// var app = angular.module("gabariteiApp",['ngResource', 'ngRoute', 'ngFileUpload',
//   'homeRoutes',
//   'homeControllers',
//   'subjectsRoutes',
//   'subjectResource',
//   'subjectControllers',
//   'dataImportResource'
  
//   ]);




