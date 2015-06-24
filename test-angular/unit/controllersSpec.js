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


  describe('subjectController', function(){
    var scope, ctrl, $httpBackend;

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('subjects.json').
          respond([{"id":2,"name":"Geo","professor_id":1,"department_id":null,"descricao":null,"created_at":"2015-06-19T03:31:29.000Z","updated_at":"2015-06-19T03:31:29.000Z"}]);

      scope = $rootScope.$new();
      ctrl = $controller('subjectController', {$scope: scope});
    }));


    it('Should get subjects list', function() {
      expect(scope.subjects).toEqual([]);
      $httpBackend.flush();

      expect(scope.subjects).toEqualData(
          [{"id":2,"name":"Geo","professor_id":1,"department_id":null,"descricao":null,"created_at":"2015-06-19T03:31:29.000Z","updated_at":"2015-06-19T03:31:29.000Z"}]);
    });

  });


  describe('subjectController', function(){
    var scope, ctrl, $httpBackend;

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {
      
      scope = $rootScope.$new();
      ctrl = $controller('homeController', {$scope: scope});
    }));


    it('Should do nothing at all ;)', function() {

    });

  });



});