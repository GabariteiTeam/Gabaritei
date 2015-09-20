'use strict';

describe('unit: HomeController', function() {

    var scope, ctrl;
    beforeEach(inject(function($rootScope, $controller) {

        scope = $rootScope.$new();
        ctrl = $controller('HomeController', {
            $scope: scope
        });

    }));

    it("Should create controller", function() {
        expect(1).toBe(1);
    });

});
