'use strict';

/* jasmine specs for controllers go here */
describe('Gabaritei controllers', function() {

  beforeEach(function(){
    this.addMatchers({
      toEqualData: function(expected) {
        return angular.equals(this.actual, expected);
      }
    });
  });

  beforeEach(module('gabariteiApp'));

  describe('Message Service', function(){
    var $MessageService;
    beforeEach(inject(function(MessageService) {
    	$MessageService = MessageService;
    }));

    it("Should send and get a message", function(){
    	var common = {callback: function(message) {
    		$MessageService.getMessage();
    	}};
    	$MessageService.addObserver(common.callback);
    	spyOn(common, "callback");
    	$MessageService.sendMessage("Message Title", "Message content", "success");

    });
  });

  describe('Redirect Service', function(){
    var $RedirectService, location, route;
    beforeEach(inject(function(RedirectService, $route, $location) {
    	$RedirectService = RedirectService;
    	route = $route;
    	location = $location;
    }));

    it("Should reload", function(){
    	location.path = function(msg){return "url";};
    	spyOn(route, "reload");
    	$RedirectService.redirect("url");
    	expect(route.reload).toHaveBeenCalled();

    });

    it("Should change path", function(){
    	location.path = function(msg){return "url123";};
    	spyOn(location, "path");
    	$RedirectService.redirect("url");
    	expect(location.path).toHaveBeenCalledWith("url");
    	expect(location.path).toHaveBeenCalledWith();

    });
  });
});