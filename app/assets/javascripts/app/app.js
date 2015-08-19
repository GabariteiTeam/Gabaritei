// Proposed styleguide: https://github.com/johnpapa/angular-styleguide

/**
 * @ngdoc object
 * @name gabariteiApp
 * @description
 *
 * This is the main application module. 
 */

var APP_NAME = 'gabariteiApp';

(function() {

    'use strict';

	angular
		.module(APP_NAME, [
			'ngResource',
			'ngRoute',
			'ngAnimate',
			'mgcrea.ngStrap',
			'ngFileUpload',
			'ngTagsInput'
		]);

})();