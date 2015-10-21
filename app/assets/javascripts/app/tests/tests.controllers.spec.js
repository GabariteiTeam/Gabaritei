'use strict';

describe('unit: TestsController', function() {

    var scope, ctrl, $httpBackend, $location, $ModalService;
    var createController;
    var location;
    var expectedTests = [{
        "id": 2,
        "name": "Teste de Geografia",
        "description": "This is a test"
    }];
    var expectedTest = {
        "id": 1,
        "name": "Teste de Fisica",
        "description": "This is a test"
    };
    var $MessageService = {
        sendMessage: function(title, content, type) {}
    };
    var expectedTranslation = {};
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller, _$location_, ModalService) {
        $httpBackend    = _$httpBackend_;
        $location       = _$location_;
        $ModalService   = ModalService;
        scope           = $rootScope.$new();
        $httpBackend.expectGET('translations/en.json')
                    .respond(expectedTranslation);
        $httpBackend.expectGET('tests')
                    .respond(expectedTests);
                    
        ctrl = $controller('TestsController', {
            $scope: scope,
            MessageService: $MessageService,
            ModalService: $ModalService
        });

        createController = function() {
            scope = $rootScope.$new();
            ctrl = $controller('TestsController', {
                $scope: scope,
                $routeParams: {
                    id: "1"
                }
            });
            $httpBackend.expectGET('tests/1').respond(expectedTest);
        }

    }));


    it('Should get tests list', function() {
        expect(ctrl.tests).toEqual([]);
        $httpBackend.flush();
        expect(ctrl.tests).toEqualData(expectedTests);
    });

    it('Should get a specific test', function() {
        $httpBackend.flush();
        createController();
        $httpBackend.flush();
        expect(ctrl.test.name).toEqual(expectedTest.name);
        expect(ctrl.test.id).toEqual(expectedTest.id);
        expect(ctrl.test.description).toEqual(expectedTest.description);
    });

    it('Should send update request', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('tests').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.updateTest();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('test.updated.success');

    });

    it('Should send update request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPUT('tests').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.updateTest();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('test.updated.error');
    });

    it('Should send delete request', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('tests/1').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.deleteTest(1);
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('test.deleted.success');
    });

    it('Should send delete request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectDELETE('tests/1').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.deleteTest(1);
        ctrl.c_delete(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('test.deleted.error');
    });

    it('Should send create request', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('tests').respond({});
        spyOn($MessageService, "sendMessage");
        ctrl.createTest();
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('test.created.success');
    });

    it('Should send create request and fail', function() {
        $httpBackend.flush();
        $httpBackend.expectPOST('tests').respond(500);
        spyOn($MessageService, "sendMessage");
        ctrl.createTest(1);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('test.created.error');
    });

});
