'use strict';

beforeEach(function() {
    this.addMatchers({
        toEqualData: function(expected) {
            return angular.equals(this.actual, expected);
        }
    });
});
beforeEach(module('gabariteiApp'));
beforeEach(module('htmltemplates'));