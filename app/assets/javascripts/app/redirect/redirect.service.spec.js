'use strict';

describe('unit: RedirectService', function() {

    var $RedirectService, location, route;
    beforeEach(inject(function(RedirectService, $route, $location) {
        $RedirectService = RedirectService;
        route = $route;
        location = $location;
    }));

    it("Should reload", function() {
        location.path = function(msg) {
            return "url";
        };
        spyOn(route, "reload");
        $RedirectService.redirect("url");
        expect(route.reload).toHaveBeenCalled();

    });

    it("Should change path", function() {
        location.path = function(msg) {
            return "url123";
        };
        spyOn(location, "path");
        $RedirectService.redirect("url");
        expect(location.path).toHaveBeenCalledWith("url");
        expect(location.path).toHaveBeenCalledWith();

    });

});
