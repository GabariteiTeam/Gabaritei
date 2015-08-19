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

  describe('Questions Controller', function(){
    var scope, ctrl, $MessageService, $Question, $httpBackend;

    beforeEach(inject(function($rootScope, $controller, Question, MessageService, _$httpBackend_){
      scope = $rootScope.$new();
      $Question = Question;
      $MessageService = MessageService;
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('questions').respond([]);
      ctrl = $controller('QuestionsController', {$scope: scope, Question: $Question, MessageService: $MessageService});
    }));

    it("should initialize variables", function(){
      expect(ctrl.deleteQuestion).toBeDefined();
      expect(ctrl.questions).toBeDefined();
    });

    it("should destroy a question", function(){
      $httpBackend.expectDELETE("questions/1").respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.deleteQuestion(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it("should fail to destroy a question", function(){
      $httpBackend.expectDELETE("questions/1").respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.deleteQuestion(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });
  });

  describe('New Question Controller', function(){
    var scope, ctrl, $MessageService, $Question, $Subject, $httpBackend, $MessageService;
    var subjectList = [{name: "Subject", id: 1}];
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, Question, Subject, MessageService){
      scope = $rootScope.$new();
      $httpBackend = _$httpBackend_;
      $Question = Question;
      $Subject = Subject;
      $MessageService = MessageService;
      $httpBackend.expectGET("subjects").respond(subjectList);
      ctrl = $controller('NewQuestionController', {$scope: scope, Question: $Question, Subject: $Subject, MessageService: MessageService});
    }));

    it('should initialize variables', function(){
      expect(ctrl.question).toBeDefined();
      expect(ctrl.createQuestion).toBeDefined();
    });

    it('should get subjects list', function(){
      $httpBackend.flush();
      expect(ctrl.subjectsTags).toEqualData(["Subject"]);
      expect(ctrl.subjects).toEqualData(subjectList);
    });

    it('should create a question', function(){
      $httpBackend.flush();
      $httpBackend.expectPOST("questions").respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.subjectInput = [{text: "a"}];
      ctrl.subjects = [{name: "b", id: 2}, {name: "a", id: 1}]
      ctrl.createQuestion();
      expect(ctrl.question.subjects).toEqualData([1]);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it('should fail to create a question', function(){
      $httpBackend.flush();
      $httpBackend.expectPOST("questions").respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.subjectInput = [];
      ctrl.createQuestion();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });
  });

  describe('Update question controller', function(){
    var scope, ctrl, routeParams, $MessageService, $Question, $Subject, $httpBackend, $MessageService;
    var toUpdateQuestion, toUpdateSubjects;

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, $routeParams, Question, Subject, MessageService){
      scope = $rootScope.$new();
      $httpBackend = _$httpBackend_;
      $Question = Question;
      $Subject = Subject;
      routeParams = $routeParams;

      toUpdateQuestion = new $Question();
      toUpdateSubjects = [{id: 1, name: "Dummy"}];

      $MessageService = MessageService;

      $httpBackend.expectGET("questions/1").respond({question: toUpdateQuestion, subjects: [{name: "dummy"}]});
      $httpBackend.expectGET("subjects").respond([{name: "dummy"}]);
      routeParams.id = 1;

      ctrl = $controller('UpdateQuestionController', {$scope: scope, Question: $Question, Subject: $Subject, MessageService: MessageService, $routeParams: routeParams});

    }));

    it('should initialize variables', function(){
      ctrl.subjects = [{name: "dummy"}];
      $httpBackend.flush();
      expect(ctrl.question).toEqualData(toUpdateQuestion);
      expect(ctrl.subjects).toBeDefined();
      expect(ctrl.subjectInput[0].text).toEqual("dummy");
      expect(ctrl.subjectsTags).toEqualData(["dummy"]);
      expect(ctrl.updateQuestion).toBeDefined();
    });

    it('should update question', function(){
      $httpBackend.flush();
      $httpBackend.expectPUT('questions').respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.updateQuestion();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it('should fail to update question', function(){
      $httpBackend.flush();
      $httpBackend.expectPUT('questions').respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.updateQuestion();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

  });


});