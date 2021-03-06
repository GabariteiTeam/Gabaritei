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

  // Karma converted html files into javascript
  // and inject into $templateCache
  beforeEach(module('htmltemplates'));

  describe('Home Controller', function(){
    var scope, ctrl;
    beforeEach(inject(function($rootScope, $controller) {
      
      scope = $rootScope.$new();
      ctrl = $controller('HomeController', {$scope: scope});
 
    }));

    it("Should create controller", function() {
      expect(1).toBe(1);
    });
  });

  describe('Subject Controller', function(){
    var scope, ctrl, $httpBackend, $location;
    var createController;
    var location;
    var expectedSubjects = [{"id":2,"name":"Geografia", "description": "This is a subject"}]; 
    var expectedSubject = {"id":1,"name":"Fisica", "description": "This is a subject"};
    var $MessageService = {sendMessage: function(title, content, type) {}};
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_) {
      $httpBackend = _$httpBackend_;
      $location = _$location_;
      
      scope = $rootScope.$new();
      $httpBackend.expectGET('subjects').respond(expectedSubjects);
      
      ctrl = $controller('SubjectsController', {$scope: scope, MessageService: $MessageService});

      createController = function() {
        scope = $rootScope.$new();
        ctrl = $controller('SubjectsController', {$scope: scope, $routeParams: {id: "1"}});
        $httpBackend.expectGET('subjects/1').respond(expectedSubject);
      }

    }));

   
    it('Should get subjects list', function() {

      expect(ctrl.subjects).toEqualData({});
      $httpBackend.flush();
      expect(ctrl.subjects).toEqualData(expectedSubjects);
    });

    it('Should get a specific subject', function(){
      $httpBackend.flush();
      
      createController();
      
      $httpBackend.flush();
      expect(ctrl.subject.name).toEqual(expectedSubject.name);
      expect(ctrl.subject.id).toEqual(expectedSubject.id);
      expect(ctrl.subject.description).toEqual(expectedSubject.description);
    });

    it('Should send update request', function(){
      $httpBackend.flush();
      $httpBackend.expectPUT('subjects').respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.updateSubject();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalledWith("Updated!", "Subject was updated with success!", "success");
      
    });

    it('Should send update request and fail', function(){
      $httpBackend.flush();
      $httpBackend.expectPUT('subjects').respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.updateSubject();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT updated with success!", "error");
    });

    it('Should send delete request', function(){
      $httpBackend.flush();
      $httpBackend.expectDELETE('subjects/1').respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.deleteSubject(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalledWith("Deleted!", "Subject was deleted with success!", "success");
    });

    it('Should send delete request and fail', function(){
      $httpBackend.flush();
      $httpBackend.expectDELETE('subjects/1').respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.deleteSubject(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT deleted with success!", "error");
    });

    it('Should send create request', function(){
      $httpBackend.flush();
      $httpBackend.expectPOST('subjects').respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.createSubject();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalledWith("Created!", "Subject was created with success!", "success");
    });

    it('Should send create request and fail', function(){
      $httpBackend.flush();
      $httpBackend.expectPOST('subjects').respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.createSubject(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT created with success!", "error");
    });
  });

  describe('Message Controller', function(){
    var scope, ctrl;
    var $MessageService = {addObserver: function(callback) {}};
    var createController;
    var $Message;

    beforeEach(inject(function($rootScope, $controller, Message) {
      createController = function createController() {
        $Message = Message;
        scope = $rootScope.$new();
        ctrl = $controller('MessagesController', {$scope: scope, MessageService: $MessageService});
      }
    }));

    it('Should register an observer', function(){
      spyOn($MessageService, "addObserver");
      createController();
      //expect($MessageService.addObserver).toHaveBeenCalledWith(scope.receiveMessage);
      expect($MessageService.addObserver).toHaveBeenCalledWith(ctrl.receiveMessage);
    });

    it('Should receive a message', function(){
      createController();
      //On the service, it should be a Message object, not a string
      var message = new $Message();
      message.title = "Hello World!";
      message.content = "Hello Gabaritei!";
      message.type = "success";
      ctrl.receiveMessage(message);
      expect(ctrl.message).toEqual(message);
    });
  });


});