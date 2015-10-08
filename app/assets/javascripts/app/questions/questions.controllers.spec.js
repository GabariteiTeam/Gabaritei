describe('Questions Controller', function(){
    var scope, ctrl, $MessageService, $Question, $httpBackend;

    beforeEach(inject(function($rootScope, $controller, Question, MessageService, _$httpBackend_){
      scope = $rootScope.$new();
      $Question = Question;
      $MessageService = MessageService;
      $httpBackend = _$httpBackend_;
      $httpBackend.expectGET('translations/en.json').respond({});
      $httpBackend.expectGET('questions').respond([]);
      ctrl = $controller('QuestionsController', {$scope: scope, Question: $Question, MessageService: $MessageService});
    }));

    it("should initialize variables", function(){
      expect(ctrl.questions).toBeDefined();
    });

    it("should destroy a question", function(){
      $httpBackend.expectDELETE("questions/1").respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.c_delete(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it("should fail to destroy a question", function(){
      $httpBackend.expectDELETE("questions/1").respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.c_delete(1);
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
      $httpBackend.expectGET('translations/en.json').respond({});
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
      $httpBackend.expectPOST("questions?subjects%5B%5D=1").respond({});
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

      $httpBackend.expectGET('translations/en.json').respond({});
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