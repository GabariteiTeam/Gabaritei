'use strict';

describe('unit: SubjectsController', function() {

    var scope, ctrl, $httpBackend, $location;
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
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_) {
        $httpBackend = _$httpBackend_;
        $location = _$location_;

        scope = $rootScope.$new();
        $httpBackend.expectGET('translations/en.json').respond(expectedTranslation);
        $httpBackend.expectGET('subjects').respond(expectedSubjects);


        ctrl = $controller('SubjectsController', {
            $scope: scope,
            MessageService: $MessageService
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
        //expect(scope.subjects).toEqual([]);
        expect(ctrl.subjects).toEqual([]);
        $httpBackend.flush();

        //expect(scope.subjects).toEqualData(expectedSubjects);
        expect(ctrl.subjects).toEqualData(expectedSubjects);
    });

    it('Should get a specific subject', function() {
        $httpBackend.flush();

        createController();

        $httpBackend.flush();
        // expect(scope.subject.name).toEqual(expectedSubject.name);
        // expect(scope.subject.id).toEqual(expectedSubject.id);
        // expect(scope.subject.description).toEqual(expectedSubject.description);
        expect(ctrl.subject.name).toEqual(expectedSubject.name);
        expect(ctrl.subject.id).toEqual(expectedSubject.id);
        expect(ctrl.subject.description).toEqual(expectedSubject.description);
    });

    it('Should send update request', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('subjects').respond({});
        spyOn($MessageService, "sendMessage");
        //scope.updateSubject();
        ctrl.updateSubject();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Updated!", "Subject was updated with success!", "success");

    });

    it('Should send update request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('subjects').respond(500);
        spyOn($MessageService, "sendMessage");
        //scope.updateSubject();
        ctrl.updateSubject();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT updated with success!", "error");
    });

    it('Should send delete request', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('subjects/1').respond({});
        spyOn($MessageService, "sendMessage");
        //scope.deleteSubject(1);
        ctrl.deleteSubject(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Deleted!", "Subject was deleted with success!", "success");
    });

    it('Should send delete request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('subjects/1').respond(500);
        spyOn($MessageService, "sendMessage");
        //scope.deleteSubject(1);
        ctrl.deleteSubject(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT deleted with success!", "error");
    });

    it('Should send create request', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('subjects').respond({});
        spyOn($MessageService, "sendMessage");
        //scope.createSubject();
        ctrl.createSubject();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Created!", "Subject was created with success!", "success");
    });

    it('Should send create request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('subjects').respond(500);
        spyOn($MessageService, "sendMessage");
        //scope.createSubject(1);
        ctrl.createSubject(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Fail!", "Subject was NOT created with success!", "error");
    });

});
