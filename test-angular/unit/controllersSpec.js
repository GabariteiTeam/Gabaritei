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
  beforeEach(module('homeControllers'));
  beforeEach(module('subjectControllers'));
  beforeEach(module('subjectResource'));

  describe('Home Controller', function(){
    var scope, ctrl;
    beforeEach(inject(function($rootScope, $controller) {
      
      scope = $rootScope.$new();
      ctrl = $controller('homeController', {$scope: scope});
    }));

    it("Should create controller", function() {
      expect(1).toBe(1);
    });
  });

  describe('Subject Controller', function(){
    var scope, ctrl, $httpBackend, $location;
    var createController;
    var createActionController;
    var createCustomLocationController;
    var location;
    var expectedSubjects = [{"id":2,"name":"Geografia", "description": "This is a subject"}]; 
    var expectedSubject = {"id":1,"name":"Fisica", "description": "This is a subject"}
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_) {
      $httpBackend = _$httpBackend_;
      $location = _$location_;
      
      scope = $rootScope.$new();
      $httpBackend.expectGET('subjects').respond(expectedSubjects);
      ctrl = $controller('subjectController', {$scope: scope});
      createController = function() {
        var routeParams = {id:"1"};
        $httpBackend.expectGET('subjects/1').respond(expectedSubject);
        ctrl = $controller('subjectController', {$scope: scope, $routeParams: routeParams});
      };
      createActionController = function(status, action) {
        var routeParams = {status: status, action: action};
        $httpBackend.expectGET('subjects').respond(expectedSubject);
        ctrl = $controller('subjectController', {$scope: scope, $routeParams: routeParams});
      };
      createCustomLocationController = function(){
        location = {path: function(){return "/abc";}, reload: function(){}};
        $httpBackend.expectGET('subjects').respond(expectedSubjects);
        ctrl = $controller('subjectController', {$scope: scope, $location: location});
      };
    }));

   
    it('Should get subjects list', function() {
      expect(scope.subjects).toEqual([]);
      $httpBackend.flush();

      expect(scope.subjects).toEqualData(expectedSubjects);
    });

    it('Should get a specific subject', function(){
      createController();
      
      $httpBackend.flush();
      expect(scope.subject.name).toEqual(expectedSubject.name);
      expect(scope.subject.id).toEqual(expectedSubject.id);
      expect(scope.subject.description).toEqual(expectedSubject.description);

    });

    it('Should create a ok message', function(){
      createActionController("ok", "deleted");
      expect(scope.message.content).toEqual("Subject deleted with success!");
      expect(scope.message.isSuccess).toBe(true);
      expect(scope.message.showMessage).toBe(true);
    });

    it('Should create a error message', function(){
      createActionController("error", "deleted");
      expect(scope.message.content).toEqual("Subject not deleted with success!");
      expect(scope.message.isError).toBe(true);
      expect(scope.message.showMessage).toBe(true);
    });

    it('Should redirect', function(){
      scope.redirect("/subjects");
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects");
    });

    it('Should still redirect', function(){
      $httpBackend.flush();
      createCustomLocationController();
      $httpBackend.flush();
      var path = "/abc";
      spyOn(location, 'reload');
      scope.redirect(path);
      expect(location.reload).toHaveBeenCalled();
    });

    it('Should send update request', function(){
      $httpBackend.flush();
      $httpBackend.expectPUT('subjects').respond({});
      scope.updateSubject();
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects/success/ok/updated");
    });

    it('Should send update request and fail', function(){
      $httpBackend.flush();
      $httpBackend.expectPUT('subjects').respond(500);
      scope.updateSubject();
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects/success/error/updated");
    });

    it('Should send delete request', function(){
      $httpBackend.flush();
      $httpBackend.expectDELETE('subjects/1').respond({});
      scope.deleteSubject(1);
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects/success/ok/deleted");
    });

    it('Should send delete request and fail', function(){
      $httpBackend.flush();
      $httpBackend.expectDELETE('subjects/1').respond(500);
      scope.deleteSubject(1);
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects/success/error/deleted");
    });

    it('Should send create request', function(){
      $httpBackend.flush();
      $httpBackend.expectPOST('subjects').respond({});
      scope.createSubject();
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects/success/ok/created");
    });

    it('Should send create request and fail', function(){
      $httpBackend.flush();
      $httpBackend.expectPOST('subjects').respond(500);
      scope.createSubject(1);
      $httpBackend.flush();
      expect($location.path()).toEqual("/subjects/success/error/created");
    });
  });

});