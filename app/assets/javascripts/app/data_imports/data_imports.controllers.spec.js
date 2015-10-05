'use strict';

describe('unit: DataImportsController', function() {

    var scope, ctrl, $httpBackend, $timeout, timerCallback;
    var initialDataImports = [
        {id: 1, model: 0, status: -1, role: 1}
    ];
    var importingDataImports = [
        {id: 1, model: 0, status: 0, role: 1}
    ];
    var $MessageService = {
        sendMessage: function(title, content, type) {}
    };
    var roles = [
        {id: 1, name: 'Admin'}, 
        {id: 2, name: 'Student'},
        {id: 3, name: 'Teacher'}
    ];
    

    beforeEach(inject(function(_$httpBackend_, _$timeout_, $rootScope, $controller) {
        $httpBackend = _$httpBackend_;
        $timeout = _$timeout_;
        scope = $rootScope.$new();
        ctrl = $controller('DataImportsController', {
            $scope: scope,
            MessageService: $MessageService
        });
        $httpBackend.expectGET('translations/en.json').respond({});
        $httpBackend.expectGET('roles.json').respond(roles);
    }));

    it("should retrieve roles", function() {
        $httpBackend.expectGET('data_imports.json').respond(initialDataImports);
        $httpBackend.flush();
        expect(ctrl.user_roles).toEqualData(roles);
    });

    it("should refresh data", function() {
        $httpBackend.expectGET('data_imports.json').respond(initialDataImports);
        $httpBackend.flush();
        ctrl.refresh();
        $httpBackend.expectGET('data_imports.json').respond(initialDataImports);
        $httpBackend.flush();
    });

    it("should refresh data and poll server", function() {
        ctrl.refresh();
        spyOn(ctrl, "refresh");
        $httpBackend.expectGET('data_imports.json').respond(importingDataImports);
        $httpBackend.flush();
        $timeout.flush();
        expect(ctrl.refresh).toHaveBeenCalled();
    });

    it("should upload file", function() {
        ctrl.data_import.model = 0;
        ctrl.data_import.role = 1;
        ctrl.data_import.file = {
            type: "text/csv"
        };
        spyOn($MessageService, "sendMessage");
        spyOn(ctrl, "refresh");
        $httpBackend.expectPOST('/data_imports').respond({});
        $httpBackend.flush();
        ctrl.uploadFile();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('data_import.uploaded.success');
        expect(ctrl.refresh).toHaveBeenCalled();
    });

    it("should upload file and fail", function() {
        ctrl.data_import.model = 0;
        ctrl.data_import.role = 1;
        ctrl.data_import.file = {
            type: "text/csv"
        };
        spyOn($MessageService, "sendMessage");
        $httpBackend.expectPOST('/data_imports').respond(500);
        $httpBackend.expectGET('data_imports.json').respond(initialDataImports);
        $httpBackend.flush();
        ctrl.uploadFile();
        expect(ctrl.fileUpload.uploading).toBe(false);
        expect($MessageService.sendMessage).toHaveBeenCalledWith('data_import.uploaded.error');
    });

    it("should import data", function() {
        spyOn(ctrl, "refresh");
        ctrl.importData(initialDataImports[0].id);
        $httpBackend.expectPUT('data_imports/' + initialDataImports[0].id + "/import").respond({});
        $httpBackend.flush();
        expect(ctrl.refresh).toHaveBeenCalled();
    });

    it("should delete file", function() {
        spyOn($MessageService, "sendMessage");
        spyOn(ctrl, "refresh");
        ctrl.deleteFile(initialDataImports[0].id);
        $httpBackend.expectDELETE('data_imports/' + initialDataImports[0].id + ".json").respond({});
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('data_import.deleted.success');
        expect(ctrl.refresh).toHaveBeenCalled();
    });

    it("should delete file and fail", function() {
        spyOn($MessageService, "sendMessage");
        ctrl.deleteFile(initialDataImports[0].id);
        $httpBackend.expectDELETE('data_imports/' + initialDataImports[0].id + ".json").respond(500);
        $httpBackend.expectGET('data_imports.json').respond(initialDataImports);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith('data_import.deleted.error');
    });

});
