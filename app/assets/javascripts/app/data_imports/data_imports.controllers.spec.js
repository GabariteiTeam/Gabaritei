// TODO: write tests of data import module!

'use strict';

describe('unit: DataImportsController', function() {

    var scope, ctrl, $httpBackend;
    var expectedDataImports = [
        {id: 1, model: 0, status: -1, progress: 0, col_sep: ";"}
    ];
    var expectedTranslation = {};
    var expectedModels = [
        "Admin",
        "Student",
        "Teacher",
        "Subjects",
        "Fields",
        "Courses"
    ];
    beforeEach(inject(function(_$httpBackend_, $rootScope, $controller) {
        $httpBackend = _$httpBackend_;
        scope = $rootScope.$new();
        ctrl = $controller('DataImportsController', {
            $scope: scope
        });
        $httpBackend.expectGET('translations/en.json').respond(expectedTranslation);
        $httpBackend.expectGET('data_imports/models.json').respond(expectedModels);
        $httpBackend.expectGET('data_imports.json').respond(expectedDataImports);
    }));

    it("should retrieve data imports list", function() {
        expect(ctrl.data_imports).toEqual([]);
        $httpBackend.flush();
        expect(ctrl.data_imports).toEqualData(expectedDataImports);
    });

    it("should upload file", function() {
        ctrl.uploadFile();
        $httpBackend.expectPOST('data_imports').respond({});
        $httpBackend.expectGET('data_imports.json').respond(expectedDataImports);
        $httpBackend.flush();
    });

});
