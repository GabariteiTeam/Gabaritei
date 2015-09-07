'use strict';

describe('unit: DataImportsController', function() {

    var scope, ctrl, $httpBackend, $timeout, timerCallback;
    var initialDataImports = [
        {id: 1, model: 0, status: -1, progress: 0, col_sep: ";"}
    ];
    var importingDataImports = [
        {id: 1, model: 0, status: 0, progress: 0, col_sep: ";"}
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
        ctrl.data_import.file = {
            type: "text/csv"
        };
        spyOn($MessageService, "sendMessage");
        spyOn(ctrl, "refresh");
        ctrl.uploadFile();
        $httpBackend.expectPOST('data_imports').respond({});
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Uploaded!", "File was uploaded with success!", "success");
        expect(ctrl.refresh).toHaveBeenCalled();
    });

    it("should upload file and fail", function() {
        ctrl.data_import.file = {
            type: "text/csv"
        };
        spyOn($MessageService, "sendMessage");
        ctrl.uploadFile();
        $httpBackend.expectPOST('data_imports').respond(500);
        $httpBackend.flush();
        expect(ctrl.missingFile).toBe(true);
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Error!", "File could not be uploaded!", "error");
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
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Deleted!", "File was deleted with success!", "success");
        expect(ctrl.refresh).toHaveBeenCalled();
    });

    it("should delete file and fail", function() {
        spyOn($MessageService, "sendMessage");
        ctrl.deleteFile(initialDataImports[0].id);
        $httpBackend.expectDELETE('data_imports/' + initialDataImports[0].id + ".json").respond(500);
        $httpBackend.flush();
        expect($MessageService.sendMessage).toHaveBeenCalledWith("Error!", "File could not be deleted!", "error");
    });

    it("should detect that file type changed", function() {
        var inputElementCSV = {
            files: [{
                type: "text/csv"
            }]
        };
        var inputElementXLS = {
            files: [{
                type: "xls"
            }]
        };
        expect(ctrl.csv_file).toBe(false);
        ctrl.fileNameChanged(inputElementCSV);
        expect(ctrl.csv_file).toBe(true);
        ctrl.fileNameChanged(inputElementXLS);
        expect(ctrl.csv_file).toBe(false);
    });

});
