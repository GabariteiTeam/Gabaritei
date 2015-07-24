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
			'ngAnimate',
			'mgcrea.ngStrap',
			'ngFileUpload'
		]);

})();