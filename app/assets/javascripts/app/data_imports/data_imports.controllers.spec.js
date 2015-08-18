'use strict';

describe('unit: DataImportsController', function() {

    beforeEach(function() {
        this.addMatchers({
            toEqualData: function(expected) {
                return angular.equals(this.actual, expected);
            }
        });
    });
    beforeEach(module('gabariteiApp'));
    beforeEach(module('htmltemplates'));

    var scope, ctrl;
    beforeEach(inject(function($rootScope, $controller) {
        scope = $rootScope.$new();
        ctrl = $controller('DataImportsController', {
            $scope: scope
        });
    }));

    it("Should create controller", function() {
        expect(1).toBe(1);
    });

});
