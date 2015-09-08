describe('Fields Controller', function(){
    var scope, ctrl, $MessageService, 
        $Field, $httpBackend, $Subject, 
        $ModalService;
    
    var id = 1;

    beforeEach(inject(function($rootScope, $controller, Field, Subject, MessageService, $routeParams, Modal, ModalService, _$httpBackend_){
      scope               = $rootScope.$new();
      $Field              = Field;
      $Subject            = Subject;
      $routeParams.id     = id;
      $MessageService     = MessageService;
      $ModalService       = ModalService;
      $httpBackend        = _$httpBackend_;
      $httpBackend
        .expectGET('translations/en.json')
        .respond({});
      $httpBackend
        .expectGET('fields/' + id)
        .respond([]);
      $httpBackend
        .expectGET('subjects/' + id)
        .respond({});
      ctrl = $controller('FieldsController', 
          {
            $scope: scope, 
            MessageService: $MessageService, 
            Subject: $Subject,
            ModalService: $ModalService,
            Modal: Modal
          });
    }));

    it("should initialize variables", function(){
      expect(ctrl.fields).toBeDefined();
      expect(ctrl.subject).toBeDefined();
    });
    
    it("should confirm a deleted", function(){
      spyOn($ModalService, "alert");
      ctrl.confirmDelete(1);
      expect($ModalService.alert).toHaveBeenCalled();
    });
    
    it("should destroy a field", function(){
      $httpBackend.expectDELETE("fields/" + id).respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.confirmed_delete(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it("should fail to destroy a field", function(){
      $httpBackend.expectDELETE("fields/1").respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.confirmed_delete(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });
  });

  describe('Fields Create Controller', function(){
    var scope, ctrl, $MessageService, $Question, 
        $Subject, $httpBackend, $MessageService, 
        $ModalService;
    var subjectList = [{name: "Subject", id: 1}];
    beforeEach(inject(function($rootScope, $controller, Field, Subject, MessageService, $routeParams, Modal, ModalService, _$httpBackend_){
      scope                   = $rootScope.$new();
      $Field                  = Field;
      $Subject                = Subject;
      $routeParams.subject_id = 1;
      $MessageService         = MessageService;
      $ModalService           = ModalService;
      $httpBackend            = _$httpBackend_;
      $httpBackend
        .expectGET('translations/en.json')
        .respond({});
      ctrl = $controller('FieldsCreateController', 
        {
         $scope: scope, 
         $routeParams: $routeParams, 
         MessageService: $MessageService, 
         Subject: $Subject, 
         ModalService: $ModalService
        });
    }));

    it('should initialize variables', function(){
      expect(ctrl.field).toBeDefined();
      expect(ctrl.subject_id).toBe(1);
    });

    it('should create a field', function(){
      $httpBackend.flush();
      $httpBackend
        .expectPOST("fields")
        .respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.createField();
      expect(ctrl.field.subject_id).toEqualData(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it('should fail to create a field', function(){
      $httpBackend.flush();
      $httpBackend
        .expectPOST("fields")
        .respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.createField();
      expect(ctrl.field.subject_id).toEqualData(1);
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });
  });

  describe('Update question controller', function(){
    var scope, ctrl, routeParams, $MessageService, 
        $Field, $httpBackend, $MessageService;
    var toUpdateField;
    var expectedField = 
          {
            id: 1,
            name: "Dummy",
            description: "dummy description"
          };

    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, $routeParams, Field, MessageService){
      scope         = $rootScope.$new();
      $httpBackend  = _$httpBackend_;
      $Field        = Field;
      routeParams   = $routeParams;

      toUpdateField = new $Field();
      toUpdateField = expectedField;

      $MessageService = MessageService;

      $httpBackend
        .expectGET('translations/en.json')
        .respond({});
      $httpBackend
        .expectGET("/field/1/edit")
        .respond(expectedField);
      
      routeParams.subject_id  = 1;
      routeParams.id          = 1;

      ctrl = $controller('FieldsUpdateController', 
        {
          $scope: scope, 
          Field: $Field, 
          MessageService: MessageService, 
          $routeParams: routeParams
        });

    }));

    it('should initialize variables', function(){
      expect(ctrl.subject_id).toEqual(1);
      $httpBackend.flush();
      expect(ctrl.field).toEqualData(expectedField);
      
    });

    it('should update field', function(){
      $httpBackend.flush();
      $httpBackend
        .expectPUT('/fields')
        .respond({});
      spyOn($MessageService, "sendMessage");
      ctrl.updateField();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

    it('should fail to update field', function(){
      $httpBackend.flush();
      $httpBackend
        .expectPUT('/fields')
        .respond(500);
      spyOn($MessageService, "sendMessage");
      ctrl.updateField();
      $httpBackend.flush();
      expect($MessageService.sendMessage).toHaveBeenCalled();
    });

  });