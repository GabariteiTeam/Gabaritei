'use strict';

beforeEach(function() {
    jasmine.addMatchers({
        toEqualData: function(util, customEqualityTesters) {
            return {
            	compare: function(actual, expected) {
            		var passed = angular.equals(actual, expected);
            		return {
                		pass: passed,
                		message: 'Expected ' + actual + (passed ? '' : ' not') + ' to equal ' + expected
              		};
            	}
        	}
        }
    });
    module('gabariteiApp');
	module('htmltemplates');
});