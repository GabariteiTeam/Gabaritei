'use strict';

describe('unit: SubjectsController', function() {

    var scope, ctrl, $httpBackend, $location, $ModalService;
    var createController;
    var location;
    var expectedSubjects = [{
        "id": 2,
        "name": "Geografia",
        "description": "This is a subject"
    }];
    var expectedSubject = {
        "id": 1,
        "name": "Fisica",
        "description": "This is a subject"
    };
    var $MessageService = {
        sendMessage: function(title, content, type) {}
    };
    var expectedTranslation = {};
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_, ModalService) {
        $httpBackend = _$httpBackend_;
        $location = _$location_;

        $ModalService = ModalService;
        scope = $rootScope.$new();
        $httpBackend.expectGET('translations/en.json')
                    .respond(expectedTranslation);
        $httpBackend.expectGET('subjects')
                    .respond(expectedSubjects);
                    
        ctrl = $controller('SubjectsController', {
            $scope: scope,
            MessageService: $MessageService,
            ModalService: $ModalService
        });

        createController = function() {
            scope = $rootScope.$new();
            ctrl = $controller('SubjectsController', {
                $scope: scope,
                $routeParams: {
                    id: "1"
                }
            });
            $httpBackend.expectGET('subjects/1').respond(expectedSubject);
        }

    }));


    it('Should get subjects list', function() {
        expect(ctrl.subjects).toEqual([]);
        $httpBackend.flush();
        expect(ctrl.subjects).toEqualData(expectedSubjects);
    });

    it('Should get a specific subject', function() {
        $httpBackend.flush();
        createController();
        $httpBackend.flush();
        expect(ctrl.subject.name).toEqual(expectedSubject.name);
        expect(ctrl.subject.id).toEqual(expectedSubject.id);
        expect(ctrl.subject.description).toEqual(expectedSubject.description);
    });

    it('Should send update request', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('subjects').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.updateSubject();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Updated!", "Subject was updated with success!", "success");

    });

    it('Should send update request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('subjects').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.updateSubject();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT updated with success!", "error");
    });

    it('Should send delete request', function() {
        $httpBackend.flush();
        $httpBackend.expectGET('subjects/validate/destroy/1').respond({model_bind: true, count: 1});
        $httpBackend.expectDELETE('subjects/1').respond({});
        spyOn($MessageService, "sendMessage");
        spyOn($ModalService, "customModal");
        ctrl.deleteSubject(1);
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Deleted!", "Subject was deleted with success!", "success");
        expect($ModalService.customModal).toHaveBeenCalled();
    });

    it('Should send delete request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectGET('subjects/validate/destroy/1').respond({model_bind: false, count: 1});
        $httpBackend.expectDELETE('subjects/1').respond(500);
        spyOn($ModalService, "customModal");
        spyOn($MessageService, "sendMessage");
        ctrl.deleteSubject(1);
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($ModalService.customModal).toHaveBeenCalled();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT deleted with success!", "error");
    });

    it('Should send create request', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('subjects').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.createSubject();
        $httpBackend.flush();
        //expect($MessageService.sendMessage).toHaveBeenCalledWith("Created!", "Subject was created with success!", "success");
        expect($MessageService.sendMessage).toHaveBeenCalledWith('subject.created.success');
    });

    it('Should send create request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('subjects').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.createSubject(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT created with success!", "error");
    });

});
